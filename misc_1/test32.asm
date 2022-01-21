%include "io64.inc"

section .bss
    a resd 1
    n resd 1
    i resd 1

section .data
    ar dd 21, 0, 1, 3, 7

section .text
global CMAIN
CMAIN:
    mov eax, ar
    mov dword [a], eax
    mov dword [n], 5
    
    mov eax, dword [n]
    mov dword [i], eax
    dec dword [i]
    mov ecx, dword [i]
    mov edx, 4
    imul ecx, edx
    add dword [a], ecx
L1:
    cmp dword [i], 0
    jl FIN
    mov eax, dword [a]
    cmp dword [eax], 0
    jnge FIN
    cmp dword [eax], 1
    je L2
    dec dword [eax]
L2:
    sub dword [a], 4
    dec dword [i]
    jmp L1
FIN:
    mov eax, ar
    mov ecx, 5
    
PRINT:
    PRINT_DEC 4, [eax]
    NEWLINE
    add eax, 4
    dec ecx
    cmp ecx, 0
    jne PRINT
    
    xor rax, rax
    ret