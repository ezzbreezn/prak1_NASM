%include "io.inc"

section .bss
    a resd 1
    b resd 1
    c resd 1
    x resd 1

section .text
global CMAIN
CMAIN:
    GET_HEX 4, [a]
    GET_HEX 4, [b]
    GET_HEX 4, [c]
    mov ecx, dword[c]
    mov eax, dword[a]
    and eax, ecx
    not ecx
    and ecx, dword[b]
    or eax, ecx
    PRINT_HEX 4, eax
    xor eax, eax
    ret