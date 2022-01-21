%include "io64.inc"

section .bss
    b resd 1

section .data
    s dd 1
    a dd 8
    
section .text
global CMAIN
CMAIN:
    ;mov eax, 1
;L:
    ;xchg eax, dword [s]
    ;PRINT_DEC 4, eax
    ;NEWLINE
    ;cmp eax, 1
    ;je L
    ;mov ecx, 4
    ;lzcnt eax, dword [a]
    ;popcnt eax, ecx
    ;PRINT_DEC 4, eax
    ;NEWLINE
    
    ;mov eax, a
    mov dword [b], a
    mov ebx, dword [b]
    test ebx, ebx
    je L
    cmp dword [ebx], 0
    jne L
    mov dword [ebx], 1
L:
    mov eax, dword [b]
    PRINT_DEC 4, [eax]
    NEWLINE
    xor rax, rax
    ret