%include "io64.inc"

section .bss
    a resd 1
    n resd 1
    
section .data
    arr dd 1, 2, 0, 4, -2, 4, 9, 11

section .text
global CMAIN
CMAIN:
    mov rbp, rsp; for correct debugging
    mov eax, arr
    mov dword [a], eax
    mov dword [n], 8
    
    mov ecx, dword [n]
    mov edx, 4
    imul ecx, edx
    ;PRINT_DEC 4, ecx
    ;NEWLINE
    add dword [a], ecx
    ;PRINT_DEC 4, [arr + 32]
    ;NEWLINE
    
L1:
    mov eax, dword [a]
    ;mov ebx, dword [eax]
    ;cmp ebx, 0
    cmp dword [eax], 0
    ;PRINT_DEC 4, [eax]
    ;NEWLINE
    jl OT
    je L2
    dec dword [eax]

L2:
    cmp dword [n], 0
    je OT
    dec dword [n]
    sub dword [a], 4
    jmp L1
    
OT:
    
    mov eax, arr
    mov ecx, 8
PRINT:
    PRINT_DEC 4, [eax]
    NEWLINE
    add eax, 4
    dec ecx
    cmp ecx, 0
    jne PRINT
    
    xor rax, rax
    ret