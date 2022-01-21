%include "io.inc"

section .bss
    a resd 1
    b resd 1
    ans resd 1

section .text
global CMAIN
CMAIN:
    ;GET_DEC 4, [a]
    ;GET_DEC 4, [b]
    
    ;mov eax, dword[a]
    ;mov ebx, dword[b]
    GET_DEC 4, eax
    GET_DEC 4, ebx

    cmp eax, ebx
    jge .skip
    xchg eax, ebx
.skip: 
.L:
    test ebx, ebx
    je .EL
    xor edx, edx
    div ebx
    mov eax, ebx
    mov ebx, edx
    jmp .L
.EL:      
    PRINT_DEC 4, eax
            
    xor eax, eax
    ret