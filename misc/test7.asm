%include "io64.inc"

section .data
    b dd 1
    c dd -2
    d dd 3
    
section .bss
    a resd 1
    x resd 1
    y resd 1

section .text
global CMAIN
CMAIN:
    ;mov eax, dword [c]
    ;mov edx, dword [d]
    ;imul eax, edx
    ;add eax, dword [b]
    ;mov dword [a], eax
    
    
    ;mov eax, dword [c]
    ;imul dword [d]
    ;add eax, dword [b]
    ;mov dword [a], eax
    ;PRINT_DEC 4, [a]
    ;NEWLINE
    
    GET_DEC 4, [x]
    GET_DEC 4, [y]
    mov eax, dword [x]
    mov edx, eax
    sar edx, 31
    neg dword [y]
    idiv dword [y]
    mov dword [x], eax
    PRINT_DEC 4, [x]
    NEWLINE
    xor rax, rax
    ret