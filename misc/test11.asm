%include "io64.inc"

section .bss
    a resd 2
    b resd 2

section .text
global CMAIN
CMAIN:
    GET_DEC 8, [a]
    GET_DEC 8, [b]
    ;mov eax, dword [a]
    ;mov ebx, dword [a + 4]
    ;add eax, dword [b]
    ;adc ebx, dword [b + 4]
    ;mov dword [a], eax
    ;mov dword [a + 4], ebx
    ;PRINT_DEC 8, [a]
    mov eax, dword [a]
    mov ebx, dword [a + 4]
    sub eax, dword [b]
    sbb ebx, dword [b + 4]
    mov dword [a], eax
    mov dword [a + 4], ebx
    PRINT_DEC 8, [a]
    NEWLINE
    xor rax, rax
    ret