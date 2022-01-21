%include "io64.inc"

section .bss
    a resd 1
    d resd 1
    n resd 1

section .text
global CMAIN
CMAIN:
    GET_DEC 4, [a]
    GET_DEC 4, [d]
    GET_DEC 4, [n]
    mov eax, dword[a]
    mov edx, 0
    mov ecx, dword[n]
    
.lp:
    add edx, eax
    add eax, dword[d]
    loop .lp
    
    PRINT_DEC 4, edx
    NEWLINE
    xor rax, rax
    ret