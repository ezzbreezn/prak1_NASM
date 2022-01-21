%include "io64.inc"

section .bss
    a resd 1
    n resd 1
    i resd 1
    
section .data
    arr dd 1, 0, 5, 6, 1

section .text
global CMAIN
CMAIN:
    mov dword [i], 0
    mov dword [n], 5
    mov ecx, dword [n]
    mov eax, arr
    mov dword [a], eax
L1:
    cmp ecx, dword [i]
    jnge .out
    mov eax, dword [a]
    mov edx, dword [i]
    inc edx
    mov dword [eax], edx
    add dword [a], 4
    inc dword [i]
    jmp L1
.out:
    mov eax, arr
    
PRINT:
    PRINT_DEC 4, [eax]
    NEWLINE
    add eax, 4
    dec ecx
    cmp ecx, 0
    jne PRINT
    xor rax, rax
    ret