%include "io.inc"

section .bss
    a resd 1
    b resd 1
    c resd 1
    v resd 1
    temp1 resd 1
    temp2 resd 1
    temp3 resd 1
    
section .text
global CMAIN
CMAIN:
    GET_DEC 4, [a]
    GET_DEC 4, [b]
    GET_DEC 4, [c]
    GET_DEC 4, [v]
    mov eax, dword[a]
    xor edx, edx
    mul dword[b]
    mov dword[temp1], edx
    xor edx, edx
    mul dword[c]
    mov dword[temp2], edx
    mov dword[temp3], eax
    mov eax, dword[temp1]
    mul dword[c]
    add eax, dword[temp2]
    mov edx, eax
    mov eax, dword[temp3]
    div dword[v]
    PRINT_UDEC 4, eax
    xor eax, eax
    ret
