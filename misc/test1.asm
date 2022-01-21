%include "io64.inc"

section .data
    a db 5, 0, 1, 0
    b dd 655365
    
section .bss
    

section .text
global CMAIN
CMAIN:
    PRINT_DEC 4, [a]
    NEWLINE
    PRINT_DEC 4, [b]
    NEWLINE
    xor rax, rax
    ret