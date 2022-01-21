%include "io.inc"

section .bss
    a resb 1
    b resb 1
    c resb 1
    d resb 1
    x resd 1

section .text
global CMAIN
CMAIN:
    GET_UDEC 1, [a]
    GET_UDEC 1, [b]
    GET_UDEC 1, [c]
    GET_UDEC 1, [d]
    mov al, byte[a]
    mov byte[x], al
    mov al, byte[b]
    mov byte[x + 1], al
    mov al, byte[c]
    mov byte[x + 2], al
    mov al, byte[d]
    mov byte[x + 3], al
    PRINT_UDEC 4, [x]
    xor eax, eax
    ret