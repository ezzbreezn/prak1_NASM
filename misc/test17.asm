%include "io64.inc"

section .bss
    a resd 50
    p resd 1
    q resd 1
    n resd 1

section .text
global CMAIN
CMAIN:
    mov eax, a
    add eax, 40
    mov dword [p], eax
    add eax, 60
    mov dword [q], eax
    sub eax, dword [p]
    mov edx, eax
    sar edx, 31
    mov ecx, 4
    idiv ecx
    mov dword [n], eax
    xor rax, rax
    ret