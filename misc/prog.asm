%include "io.inc"

section .data
    msg db 'sasi gooi'

section .text
global CMAIN
CMAIN:
    PRINT_STRING [msg]
    xor eax, eax
    ret