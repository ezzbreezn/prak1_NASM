%include "io.inc"

section .bss
    n resd 1
    

section .text
global CMAIN
CMAIN:
    GET_DEC 4, eax
    mov ebx, 8
    xor ecx, ecx
    cmp eax, 0
    jle .neg
.L:
    test eax, eax
    je .EL
    cmp eax, 1
    je .EL
    xor edx, edx
    div ebx
    test edx, edx
    je .skip
.neg:    
    PRINT_STRING `NO`
    xor eax, eax
    ret
.skip:        
    inc ecx
    jmp .L
.EL:    
    PRINT_STRING `YES\n`
    PRINT_DEC 4, ecx
    xor eax, eax
    ret