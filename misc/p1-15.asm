%include "io.inc"

section .bss
    x1 resd 1
    y1 resd 1
    x2 resd 1
    y2 resd 1
    x3 resd 1
    y3 resd 1
    res resd 1
    
section .text
global CMAIN
CMAIN:
    GET_DEC 4, [x1]
    GET_DEC 4, [y1]
    GET_DEC 4, [x2]
    GET_DEC 4, [y2]
    GET_DEC 4, [x3]
    GET_DEC 4, [y3]
    mov eax, dword[x1]
    sub eax, dword[x3]
    mov ecx, dword[y2]
    sub ecx, dword[y3]
    imul eax, ecx
    mov dword[res], eax
    mov eax, dword[x2]
    sub eax, dword[x3]
    mov ecx, dword[y1]
    sub ecx, dword[y3]
    imul eax, ecx
    sub dword[res], eax
    mov eax, dword[res]
    sar eax, 31
    imul eax, dword[res]
    add dword[res], eax
    add dword[res], eax
    mov eax, dword[res]
    xor edx, edx
    mov ecx, 2
    idiv ecx
    imul edx, 5
    PRINT_DEC 4, eax
    PRINT_CHAR '.'
    PRINT_DEC 4, edx
    xor eax, eax
    ret