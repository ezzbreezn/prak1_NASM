%include "io.inc"

section .bss
    a resd 1
    b resd 1
    c resd 1
    d resd 1
    e resd 1
    f resd 1
    ans resd 1

section .text
global CMAIN
CMAIN:
    GET_DEC 4, [a]
    GET_DEC 4, [b]
    GET_DEC 4, [c]
    GET_DEC 4, [d]
    GET_DEC 4, [e]
    GET_DEC 4, [f]
    mov eax, dword[a]
    mov ebx, dword[e]
    add ebx, dword[f]
    mul ebx
    add dword[ans], eax
    mov eax, dword[b]
    mov ebx, dword[d]
    add ebx, dword[f]
    mul ebx
    add dword[ans], eax
    mov eax, dword[c]
    mov ebx, dword[d]
    add ebx, dword[e]
    mul ebx
    add dword[ans], eax
    PRINT_DEC 4, [ans]
    xor eax, eax
    ret