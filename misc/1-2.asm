%include "io.inc"

section .bss
    a resd 1
    b resd 1
    c resd 1
    v resd 1
    p1 resd 1
    p2 resd 1
    temp resd 1

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, [a]
    GET_UDEC 4, [b]
    GET_UDEC 4, [c]
    GET_UDEC 4, [v]
    mov eax, dword[a]
    xor edx, edx
    mul dword[b]
    mov dword[p1], edx
    mov dword[p2], eax
    ;xor edx, edx
    mov eax, dword[p2]
    xor edx, edx
    mul dword[c]
    mov dword[p2], eax
    mov dword[temp], edx
    mov eax, dword[p1]
    xor edx, edx
    mul dword[c]
    add eax, dword[temp]
    mov edx, eax
    mov eax,dword[p2]
    div dword[v]
    PRINT_UDEC 4, eax
    xor eax, eax
    ret