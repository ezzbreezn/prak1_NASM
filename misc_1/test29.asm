%include "io64.inc"

section .bss
    s resd 1
    i resd 1
    
section .data
    arr db 2, 'a', 1, 0

section .text
global CMAIN
CMAIN:
    mov dword [i], 0
    mov eax, arr
    mov dword [s], eax
L1:
    mov eax, dword [s]
    mov cl, byte [eax]
    cmp cl, 0
    je .out
    add byte [eax], 'A'
    sub byte [eax], 'a'
    inc dword [s]
    inc dword [i]
    jmp L1
.out:
    
    mov ecx, 3
    mov eax, arr
PRINT:
    PRINT_CHAR [eax]
    NEWLINE
    inc eax
    dec ecx
    cmp ecx, 0
    jne PRINT
    xor rax, rax
    ret