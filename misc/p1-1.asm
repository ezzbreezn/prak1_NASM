%include "io.inc"

section .bss
    vx resd 1
    vy resd 1
    a1 resd 1
    a2 resd 1
    t resd 1
    temp resd 1

section .text
global CMAIN
CMAIN:
    GET_DEC 4, [vx]
    GET_DEC 4, [vy]
    GET_DEC 4, [a1]
    GET_DEC 4, [a2]
    GET_DEC 4, [t]
    mov eax, dword[vx]
    imul dword[t]
    mov dword[temp], eax
    mov eax, dword[a1]
    imul dword[t]
    imul dword[t]
    add dword[temp], eax
    PRINT_DEC 4, [temp]
    PRINT_CHAR " "
    mov eax, dword[vy]
    imul dword[t]
    mov dword[temp], eax
    mov eax, dword[a2]
    imul dword[t]
    imul dword[t]
    add dword[temp], eax
    PRINT_DEC 4, [temp]
    xor eax, eax
    ret