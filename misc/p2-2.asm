%include "io.inc"

section .bss
    ;n resd 1
    sum resd 1

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, eax
    mov dword[sum], 0
    mov ecx, 1
.L:
    and ecx, eax
    add dword[sum], ecx
    shr eax, 1
    mov ecx, 1
    test eax, eax
    jne .L
    
    PRINT_UDEC 4, [sum]
    xor eax, eax
    ret