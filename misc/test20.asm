%include "io64.inc"

section .bss
    p resd 1
    q resd 1

section .data
    a dq 30000000000
    b dq 40000000000
    c dq 1000

section .text
global CMAIN
CMAIN:
    ;mov rbp, rsp; for correct debugging
    ;add dword [q], 4
    ;mov eax, dword [q]
    ;mov eax, dword [eax]
    ;mov edx, dword [p]
    ;mov dword [edx], eax
    ;add dword [p], 4
    PRINT_HEX 4, [a]
    NEWLINE
    PRINT_HEX 4, [a + 4]
    NEWLINE
    mov eax, dword [a]
    mov edx, dword [a + 4]
    add eax, dword [b]
    adc edx, dword [b + 4]
    sub eax, dword [c]
    sbb edx, dword [c + 4]
    mov dword [a], eax
    mov dword [a + 4], edx
    PRINT_DEC 8, [a]
    NEWLINE
    xor rax, rax
    ret