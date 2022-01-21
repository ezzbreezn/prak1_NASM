%include "io64.inc"

section .data
    n dd 2
    a dd 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    x dd 2
    
section .bss
    f resd 1

section .text
global CMAIN
CMAIN:
    mov ecx, dword [n]
    inc ecx
    lea ebx, [a + 4 * ecx - 4]
    xor eax, eax
L:
    imul eax, dword [x]
    add eax, dword [ebx]
    sub ebx, 4
    dec ecx
    jne L
    mov dword [f], eax
    PRINT_DEC 4, [f]
    NEWLINE
    xor rax, rax
    ret