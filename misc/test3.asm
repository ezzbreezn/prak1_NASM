%include "io64.inc"

section .data
    a dw 0xDEAD
    b dw 0xF00D
    c dw 0xCAFE
    d dw 0xBABE

section .bss
    temp resd 1

section .text
global CMAIN
CMAIN:
    movsx eax, word [a + 1]
    PRINT_HEX 4, eax
    NEWLINE
    movsx ax, byte [b]
    PRINT_HEX 4, eax
    NEWLINE
    movzx eax, word [c]
    PRINT_HEX 4, eax
    NEWLINE
    movsx eax, byte [b + 2]
    PRINT_HEX 4, eax
    NEWLINE
    movzx ax, byte [d + 1]
    PRINT_HEX 4, eax
    NEWLINE
    movsx eax, word [b + 1]
    PRINT_HEX 4, eax
    NEWLINE
    mov bx, word [a + 1]
    movsx ax, bh
    PRINT_HEX 4, eax
    NEWLINE
    ;NEWLINE
    ;mov [temp], eax
    ;PRINT_HEX 1, [temp]
    ;PRINT_HEX 1, [temp + 1]
    ;PRINT_HEX 1, [temp + 2]
    ;PRINT_HEX 1, [temp + 3]
    xor rax, rax
    ret