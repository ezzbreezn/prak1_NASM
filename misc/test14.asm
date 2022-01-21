%include "io64.inc"

section .bss
    px resd 1
    py resd 1
    pp resw 1

section .text
global CMAIN
CMAIN:
    mov rbp, rsp; for correct debugging
    mov edx, dword [px]
    mov eax, dword [py]
    dec word [eax]
    mov cx, word [eax]
    mov word [edx], cx
    ;mov word [edx], word [eax]
    add dword [px], 2
    xor rax, rax
    ret