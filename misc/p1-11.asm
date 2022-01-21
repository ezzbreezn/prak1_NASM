%include "io.inc"

section .bss
    c resb 1
    y resd 1
    x resd 1

section .text
global CMAIN
CMAIN:
    GET_CHAR [c]
    GET_DEC 4, [x]
    mov cl, byte[c]
    mov al, 'A'
    sub cl, al
    inc cl
    movzx ecx, cl
    mov dword[y], ecx
    mov eax, 8
    sub eax, dword[x]
    mov ecx, 8
    sub ecx, dword[y]
    mul ecx
    shr eax, 1
    PRINT_DEC 4, eax
    xor eax, eax
    ret