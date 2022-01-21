%include "io64.inc"

section .bss
    a resq 1

section .text
global CMAIN
CMAIN:
    GET_DEC 8, [a]
    inc qword [a]
    PRINT_DEC 8, [a]
    xor rax, rax
    ret