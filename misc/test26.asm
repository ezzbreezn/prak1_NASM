%include "io64.inc"

section .bss
    s1 resd 1
    s2 resd 2
    
section .data
    a db 1, 2, 3, 4, 5, 6, 0, 8, 9

section .text
global CMAIN
CMAIN:
    mov eax, a
    mov dword [s1], eax
    mov eax, a + 3
    mov dword [s2], eax
    
L1:
    mov eax, dword [s1]
    mov edx, dword [s2]
    mov dl, byte [edx]
    mov byte [eax], dl
    inc dword [s1]
    cmp dl, 0
    je .out
    inc dword [s2]
    jmp L1
.out:
    inc dword [s2]
    
    mov ecx, 9
    mov ebx, a
PRINT:
    PRINT_DEC 1, [ebx]
    NEWLINE
    inc ebx
    dec ecx
    cmp ecx, 0
    jne PRINT
    
    xor rax, rax
    ret