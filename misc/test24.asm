%include "io64.inc"

section .bss
    p resd 1
    pp resd 1
    
section .data
    ppp dd 2

section .text
global CMAIN
CMAIN:
    mov eax, ppp
    mov dword [pp], eax
    mov eax, pp
    mov dword [p], eax
    
    mov eax, dword [p]
    cmp eax, 0
    je .out
    mov eax, dword [eax]
    mov dword [eax], 42
.out:
    PRINT_DEC 4, [ppp]
    NEWLINE
    xor rax, rax
    ret