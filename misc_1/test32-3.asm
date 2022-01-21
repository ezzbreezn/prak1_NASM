%include "io.inc"

section .data
    a dq 0x88006431FF700A2F

section .text
global CMAIN
CMAIN:
    mov eax, dword[a + 4]
    shr dword[a], 5
    shr dword[a + 4], 5
    shl eax, 27
    add dword[a], eax
    PRINT_HEX 4, [a + 4]
    PRINT_HEX 4, [a]
    xor eax, eax
    ret