%include "io64.inc"

section .data
    pp dw 10
    
section .bss
    p resd 10
    x resd 1

section .text
global CMAIN
CMAIN:
    ;mov eax, pp
    ;mov dx, word [eax]
    ;PRINT_DEC 2, dx
    ;NEWLINE
    ;PRINT_DEC 2, [pp]
    ;NEWLINE
    mov eax, dword [p + 32]
    mov eax, dword [eax]
    inc eax
    mov dword [x], eax
    
    xor rax, rax
    ret