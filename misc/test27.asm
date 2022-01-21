%include "io64.inc"

section .bss
    s1 resd 1
    l resd 1

section data
    a db 1, 2, 6, 0, 4, 8 , 0
section .text
global CMAIN
CMAIN:
    mov dword [l], 0
    mov eax, a
    mov dword [s1], eax
    
L1:
    mov eax, dword [s1]
    mov dl, byte [eax]
    cmp dl, 0
    je .out
    inc dword [l]
    inc dword [s1]
    jmp L1
.out:
    inc dword [s1]
    
    PRINT_DEC 4, [l]
    NEWLINE
    mov eax, dword [s1]
    PRINT_DEC 1, [eax]
    NEWLINE
    xor rax, rax
    ret