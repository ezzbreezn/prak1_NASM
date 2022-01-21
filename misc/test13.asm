%include "io64.inc"

section .bss
    xp resd 1
    x resd 1
    a resw 1

section .text
global CMAIN
CMAIN:
    mov rbp, rsp; for correct debugging
    mov dword [x], 228
    mov eax, dword [x]
    mov eax, dword [eax]
    mov eax, dword [eax]
    inc eax
    PRINT_DEC 4, eax
    NEWLINE
    xor rax, rax
    ret