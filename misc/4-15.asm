%include "io64.inc"

section .data
    u8 dd 100
    nS dd 10, 8, 7, 6, 5, 4, 3, 1, 1, -2

section .bss
    lim resd 1

section .text
global CMAIN
CMAIN:
    mov eax, 1
    mov esi, dword[u8]
    mov ebx, -5
    mov dword[lim], -1
    jmp .L13
.L11:
    mov dword[nS+eax*4-4], edx
    add eax, 1
    sub ebx, 5
    cmp eax, 7
    je .L10
.L13:
    mov ecx, eax
    imul ecx, eax
    lea edx, [ebx+ecx*8]
    sub edx, ecx
    cmp edx, esi
    jle .L11
    sub eax, 1
    mov dword[lim], eax
.L10:
    PRINT_DEC 4, [lim]
    NEWLINE
    NEWLINE
    mov eax, nS
    mov ecx, 10
PRINT:
    PRINT_DEC 4, [eax]
    NEWLINE
    add eax, 4
    dec ecx
    test ecx, ecx
    jne PRINT
    xor rax, rax
    ret