%include "io64.inc"

section .data
    a db 1, 2, 3, 4
    
section .bss
    b resb 4

section .text
global CMAIN
CMAIN:
    PRINT_HEX 4, [a]
    NEWLINE
    mov al, [a]
    mov [b], al
    mov ax, word [a + 2]
    mov word [b + 1], ax
    mov al, [a + 1]
    mov [b + 3], al
    PRINT_HEX 4, [b]
    NEWLINE
    xor rax, rax
    ret