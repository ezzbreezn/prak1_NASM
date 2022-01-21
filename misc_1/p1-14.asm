%include "io.inc"

section .bss
    n resd 1
    m resd 1
    k resd 1
    d resd 1
    x resd 1
    y resd 1
    all resd 1

section .text
global CMAIN
CMAIN:
    GET_DEC 4, [n]
    GET_DEC 4, [m]
    GET_DEC 4, [k]
    GET_DEC 4, [d]
    GET_DEC 4, [x]
    GET_DEC 4, [y]
    mov eax, dword[n]
    imul dword[m]
    imul dword[k]
    add eax, dword[d]
    dec eax
    xor edx, edx
    idiv dword[d]
    mov dword[all], eax
    mov ecx, dword[x]
    mov edx, 60
    imul ecx, edx
    add ecx, dword[y]
    sub ecx, 360
    sar ecx, 31
    inc ecx
    imul eax, ecx
    add eax, 2
    mov ecx, 3
    xor edx, edx
    idiv ecx
    sub dword[all], eax
    PRINT_UDEC 4, [all]
    xor eax, eax
    ret