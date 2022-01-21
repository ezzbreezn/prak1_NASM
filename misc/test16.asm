%include "io64.inc"

section .bss
    ;x resd 1
    ;px resd 1
    x resw 1
    px resd 1

section .text
global CMAIN
CMAIN:
    ;mov eax, dword [px]
    ;mov edx, dword [x]
    ;sub edx, 10
    ;mov dword [eax], edx
    ;add dword [px], 4
    sub dword [px], 2
    mov eax, dword [px]
    add eax, 4
    mov dx, word [eax]
    mov word [x], dx
    xor rax, rax
    ret