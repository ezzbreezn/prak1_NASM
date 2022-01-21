%include "io.inc"

section .data
    a dd 2
    b db -2

section .text
global CMAIN
CMAIN:
    mov eax, dword[a]
    lea ecx, [eax + 2 * eax]
    lea ecx, [eax + 2 * ecx]
    PRINT_DEC 4 , ecx
    xor eax, eax
    ret