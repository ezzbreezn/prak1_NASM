%include "io64.inc"

section .data
    aa dd 2
    b dd 7
    c dd 6
    
section .bss
    a resd 1

section .text
global CMAIN
CMAIN:
    mov rbp, rsp; for correct debugging
    mov dword [a], aa
    
    mov eax, dword [a]
    mov ebx, dword [b]
    mov ecx, dword [c]
    test eax, eax
    jz EL
    cmp ebx, ecx
    jnge EN
    add dword [eax], ebx
    jmp EN
EL:
    mov dword [a], c
    mov eax, dword [a]
    mov ebx, dword [b]
    sub dword[eax], ebx
    jmp EN
EN:
    mov eax, dword [a]
    mov eax, dword [eax]
    PRINT_DEC 4, eax
    NEWLINE
    PRINT_DEC 4, [b]
    NEWLINE
    PRINT_DEC 4, [c]
    NEWLINE
    xor rax, rax
    ret