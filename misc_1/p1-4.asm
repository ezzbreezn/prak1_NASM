%include "io.inc"

section .bss
    x resd 1
    n resd 1
    m resd 1
    y resd 1

section .text
global CMAIN
CMAIN:
    GET_DEC 4, [x]
    GET_DEC 4, [n]
    GET_DEC 4, [m]
    GET_DEC 4, [y]
    sub dword[y], 2011
    mov ecx, dword[m]
    sub dword[n], ecx
    mov eax, dword[n]
    imul dword[y]
    add dword[x], eax
    PRINT_DEC 4, [x]
    xor eax, eax
    ret