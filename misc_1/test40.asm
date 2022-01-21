%include "io64.inc"

section .data
    a dd 2000000000
    b dd 2000000000
    
section .bss
    c resb 1000
    d resd 1

section .text
global CMAIN
CMAIN:
    mov rbp, rsp; for correct debugging

    xor eax, eax
    mov dword [d], c
LOP:
    mov edx, dword [d]
    GET_CHAR [edx]
    cmp byte [edx], 0
    je LOOP_END
    inc dword [d]
    inc eax
    jmp LOP
LOOP_END:
    PRINT_STRING [c]
    NEWLINE
    PRINT_DEC 4, eax
    NEWLINE
    xor rax, rax
    ret