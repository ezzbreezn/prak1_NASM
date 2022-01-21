%include "io64.inc"

section .bss
    var resd 1

section .text
global CMAIN
CMAIN:
    GET_DEC 4, [var]
    NEG dword [var]
    PRINT_HEX 4, [var]
    NEWLINE
    mov eax, dword [var]
    PRINT_HEX 4, eax
    xor rax, rax
    ret