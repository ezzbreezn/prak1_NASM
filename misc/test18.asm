%include "io64.inc"

section .bss
    p resd 1
    pp1 resd 1
    pp2 resd 1
    pp3 resd 1
    pp4 resd 1

section .data
    ppp dw 1, 2, 3, 4

section .text
global CMAIN
CMAIN:
    mov dword [pp1], ppp
    mov dword [pp2], ppp + 2
    mov dword [pp3], ppp + 4
    mov dword [pp4], ppp + 6
    mov eax, dword [pp1]
    mov eax, dword [eax]
    PRINT_DEC 2, eax
    NEWLINE
    mov eax, dword [pp2]
    mov eax, dword [eax]
    PRINT_DEC 2, eax
    NEWLINE
    mov eax, dword [pp3]
    mov eax, dword [eax]
    PRINT_DEC 2, eax
    NEWLINE
    mov eax, dword [pp4]
    mov eax, dword [eax]
    PRINT_DEC 2, eax
    NEWLINE
    mov dword [p], pp1
    add dword [p], 12
    mov eax, dword [p]
    sub dword [eax], 4
    mov eax, dword [eax]
    ;mov cx, word [eax]
    inc word [eax]
    mov eax, dword [pp2]
    mov eax, dword [eax]
    PRINT_DEC 2, eax
    xor rax, rax
    ret