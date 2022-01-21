%include "io.inc"

section .bss
    a resd 1

section .text
global CMAIN
CMAIN:
    GET_DEC 4, [a]
    mov eax, dword[a]
    sar eax, 31
    imul eax, dword[a]
    add dword[a], eax
    add dword[a], eax
    PRINT_DEC 4, [a]
    xor eax, eax
    ret