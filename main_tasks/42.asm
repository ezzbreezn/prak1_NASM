%include "io.inc"

section .bss
    a resd 1
    ans resd 1
    n resd 1
    n1 resd 1

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, [n]
    xor ecx, ecx
.L:
    cmp ecx, dword[n]
    je .EL
    GET_UDEC 4, [a]
    push dword[a]
    inc ecx
    jmp .L
.EL:
    mov ecx, 1
    add esp, 4
    mov edx, dword[n]
    mov dword[n1], edx
    dec dword[n1]
.l1:
    cmp ecx, dword[n1]
    je .el1
    mov edx, dword[esp - 4]
    mov eax, dword[esp + 4]
    cmp edx, eax
    jne .ni
    inc dword[ans]
.ni:
    add esp, 4
    inc ecx
    jmp .l1
.el1:
    add esp, 4
    PRINT_UDEC 4, [ans]

    xor eax, eax
    ret