%include "io.inc"

section .bss
    a resd 1
    b resb 1

section .text
global CMAIN
CMAIN:
    GET_CHAR [b]
    sub byte[b], 'A'
    inc byte[b]
    GET_DEC 4, [a]
    mov eax, 8
    sub eax, dword[a]
    movsx edx, byte[b]
    mov ecx, 8
    sub ecx, edx
    xor edx, edx
    mul ecx
    shr eax,1 
    PRINT_DEC 4, eax
    xor eax, eax
    ret