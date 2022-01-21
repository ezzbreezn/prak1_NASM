%include "io64.inc"

section .bss
    q resd 1
    r resd 1
    t resd 1
    pp1 resd 1
    pp2 resd 1
    pp3 resd 1

section .data
    ppp db 15, 7, 3, 2

section .text
global CMAIN
CMAIN:
    mov dword [pp1], ppp
    mov dword [pp2], ppp + 1
    mov dword [pp3], ppp + 2
    mov dword [q], pp1
    mov dword [r], pp2
    mov dword [t], pp3
    
    ;mov eax, dword [q]
    ;mov eax, dword [eax]
    ;mov eax, dword [eax]
    ;PRINT_DEC 1, eax
    ;NEWLINE
    
    mov eax, dword [q]
    mov dword [r], eax
    add dword [q], 4
    mov eax, dword [t]
    mov ebx, dword [r]
    mov ecx, dword [ebx]
    mov dword [eax], ecx
    ;4?
    add dword [ebx], 1
    mov edx, dword [q]
    mov edx, dword [edx]
    mov eax, dword [t]
    mov eax, dword [eax]
    mov cl, byte [eax]
    ;PRINT_DEC 1, eax
    ;NEWLINE
    mov byte [edx], cl
    inc byte [eax]
    
    mov eax, dword [q]
    mov eax, dword [eax]
    mov eax, dword [eax]
    PRINT_DEC 1, eax
    NEWLINE
    mov eax, dword [r]
    mov eax, dword [eax]
    mov eax, dword [eax]
    PRINT_DEC 1, eax
    NEWLINE
    mov eax, dword [t]
    mov eax, dword [eax]
    mov eax, dword [eax]
    PRINT_DEC 1, eax
    NEWLINE
    xor rax, rax
    ret