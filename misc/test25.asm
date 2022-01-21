%include "io64.inc"

section .bss
    p resd 1
    q resd 1
    
section .data
    a dd 1, 2, 3, 4, 5, 6

section .text
global CMAIN
CMAIN:
    mov eax, a
    mov dword [p], eax
    mov eax, a + 12
    mov dword [q], eax
    
    mov eax, dword [p]
    add dword [q], 4
    mov edx, dword [q]
    mov edx, dword [edx]
    mov dword [eax], edx
    add dword [p], 4
    
    mov eax, dword [p]
    mov edx, dword [q]
    dec dword [edx]
    mov edx, dword [edx]
    mov dword [eax], edx
    add dword [p], 4
    
    mov ecx, 6
    mov ebx, a
L1:
    PRINT_DEC 4, [ebx]
    NEWLINE
    add ebx, 4
    dec ecx
    cmp ecx, 0
    jne L1

    xor rax, rax
    ret