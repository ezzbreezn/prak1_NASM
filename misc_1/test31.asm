%include "io64.inc"

section .bss
    a resd 1
    n resd 1
    
section .data
    ar dd 10, 7, -7, 2, -1, 0, 8

section .text
global CMAIN
CMAIN:
    mov dword [n], 7
    mov eax, ar
    mov dword [a], eax
    
    mov ecx, dword [n]
    mov edx, 4
    imul ecx, edx
    add dword [a], ecx
    
L1:
    cmp dword [n], 0
    je .out
    dec dword [n]
    sub dword [a], 4
    mov eax, dword [a]
    cmp dword [eax], 0
    jnge L1
    dec dword [eax]
    jmp L1
    
.out:

    mov eax, ar
    mov ecx, 7
    
PRINT:
    PRINT_DEC 4, [eax]
    NEWLINE
    add eax, 4
    dec ecx
    cmp ecx, 0
    jne PRINT
    
    xor rax, rax
    ret