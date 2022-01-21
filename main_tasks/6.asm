%include "io.inc"

section .rodata
    msg db `%d`, 0
    msgo db `Payload %d @ link %p\n`, 0
    
section .bss
    a resd 1
    n resd 1 
    prev resd 1   
    
CEXTERN scanf
CEXTERN printf 
CEXTERN malloc 

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
    mov dword[esp + 4], n
    call scanf
    
    mov dword[esp], 12
    call malloc
    mov dword[a], eax
    
    xor edi, edi
    mov esi, dword[a]
    
.L:
    cmp edi, dword[n]
    je .EL
    mov dword[esp], msg
    mov dword[esp + 4], esi
    call scanf
    
    inc edi
    mov edx, dword[prev]
    mov dword[esi + 4], edx
    
    mov dword[prev], esi
    cmp edi, dword[n]
    je .EL
    
    mov dword[esp], 12
    call malloc
    mov dword[esi + 8], eax
    mov esi, dword[esi + 8]
    jmp .L
.EL:  
    mov ecx, dword[a]
    mov edx, 1
    call F
    add esp, 8
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    xor eax, eax
    ret
    
F:
    sub esp, 16
    test ecx, ecx
    je .out
    cmp dword[ecx], 0
    je .else
    mov dword[esp], msgo
    mov eax, dword[ecx]
    mov dword[esp + 4], eax
    mov dword[esp + 8], ecx
    call printf
    jmp .out
.else:    
    cmp edx, 0
    jle .L
    mov ecx, dword[ecx + 8]
    jmp .L1 
.L:    
    mov ecx, dword[ecx + 4]
.L1:
    call F                        
.out:     
    add esp, 16
    ret     