%include "io.inc"

section .rodata
    msgs db `%hi`, 0
    msgd db `%d`, 0
    fin db `/home/boris/prak/asm/sassasm/input.bin`, 0
    rmode db `rb`, 0
    
CEXTERN fopen
CEXTERN fclose
CEXTERN fread

section .bss
    ans resd 1
    f resd 1

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 32
    
    mov dword[esp], fin
    mov dword[esp + 4], rmode
    call fopen
    
    mov dword[f], eax
    
    mov dword[esp], eax
    call F
    
    mov dword[esp], msgd
    mov dword[esp + 4], eax
    call printf
    
.L:
    
    
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    xor eax, eax
    ret
    
    
F:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 32
    
    xor edi, edi
    
.L:
    mov edx, dword[ebp + 8]
    mov dword[esp + 12], edx
    lea edx, [esp + 16]
    mov dword[esp], edx
    mov dword[esp + 4], 8
    mov dword[esp + 8], 1
    call fread
    
    test eax, eax
    je .EL
    
    cmp word[esp + 16], -273
    jne .skip
    add edi, dword[esp + 20]
    
.skip:
    jmp .L   
.EL: 
    mov eax, edi       
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    ret    