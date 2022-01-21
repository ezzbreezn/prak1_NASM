%include "io.inc"

section .rodata
    msg db `%c`, 0
    msgs db `%s`, 0
    msgd db `%d\n`, 0
    fin db `/home/boris/prak/asm/sassasm/input.txt`, 0
    rmode db `r`, 0
    
section .bss
    f resd 1
    a resd 10000
    c resb 1 
    ans resd 1
       
CEXTERN fopen
CEXTERN fclose
CEXTERN fscanf
CEXTERN strlen
CEXTERN strchr
CEXTERN fprintf

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msg
    mov dword[esp + 4], c
    call scanf
    
    mov dword[esp], fin
    mov dword[esp + 4], rmode
    call fopen
    
    mov dword[f], eax
    
    mov dword[esp], eax
    mov dword[esp + 4], a
    movsx edx, byte[c]
    mov dword[esp + 8], edx
    call F
    
    mov dword[ans], eax
    
    mov dword[esp], msgd
    mov edx, dword[ans]
    mov dword[esp + 4], edx
    call printf
    
    xor edi, edi
.L2:
    cmp edi, dword[ans]
    je .EL2    
    mov dword[esp], msgd
    mov edx, dword[a + 4 * edi]
    mov dword[esp + 4], edx
    call printf
    inc edi
    jmp .L2
    
.EL2:    
    mov edx, dword[f]
    mov dword[esp], edx
    call fclose
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
F:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 256
    sub esp, 32
    
    xor esi, esi
.L:
    mov edx, dword[ebp + 8]
    mov dword[esp], edx
    mov dword[esp + 4], msgs
    lea edx, [esp + 16]
    mov dword[esp + 8], edx
    call fscanf
    cmp eax, -1
    je .EL
    
    lea edx, [esp + 16]
    mov dword[esp], edx
    call strlen
    
    test eax, eax
    je .ni
    
    mov edi, eax
    xor eax, eax
    xor ecx, ecx
.L1:    
    cmp ecx, edi
    je .EL1
    mov dl, byte[esp + ecx + 16]
    cmp dl, byte[ebp + 16]
    jne .skip
    inc eax
.skip: 
    inc ecx
    jmp .L1
.EL1: 
    mov edx, dword[ebp + 12]
    mov dword[edx + 4 * esi], eax
    inc esi
.ni:    
    jmp .L
.EL:  
    mov eax, esi  
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    ret