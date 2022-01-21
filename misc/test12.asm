%include "io64.inc"

section .data
    a dd 10
    b dd 4
    c dd -7

section .text
global CMAIN
CMAIN:
    ;mov eax, dword [a]
    ;mov ecx, 5
    ;imul ecx
    ;mov ebx, dword [b]
    ;lea edx, [14 + ebx + 2 * eax]
    ;mov dword [c], edx
    ;PRINT_DEC 4, [c]
    
    mov eax, dword [a]
    mov ecx, 3
    imul ecx
    mov ebx, dword [b]
    lea edx, [-15 + ebx + 8 * eax]
    mov dword [c], edx
    PRINT_DEC 4, [c]
    NEWLINE
    xor rax, rax
    ret