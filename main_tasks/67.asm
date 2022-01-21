%include "io.inc"

section .bss
    n resd 1

section .text
global CMAIN
CMAIN:
    ;write your code here
    GET_UDEC 4, [n]
    mov ecx, dword[n]
    rol ecx, 1
    PRINT_DEC 4, ecx
    xor eax, eax
    ret