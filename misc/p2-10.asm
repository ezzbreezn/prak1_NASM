%include "io.inc"

section .bss
    n resd 1


section .text
global CMAIN
CMAIN:
    GET_DEC 4, [n]
    mov ecx, 2
    mov edi, 1
.L:
    mov eax, ecx
    mul ecx
    cmp eax, dword[n]
    jg .out
    mov eax, dword[n]
    xor edx, edx
    div ecx
    test edx, edx
    jne .L1
    mov ebx, ecx
    cmp ebx, eax
    cmovl ebx, eax
    cmp ebx, edi
    cmovg edi, ebx
.L1:
    inc ecx
    jmp .L
.out:
    PRINT_UDEC 4, edi
    
    xor eax, eax
    ret