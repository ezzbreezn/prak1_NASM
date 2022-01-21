%include "io.inc"

section .bss
    n resd 1
    temp resd 1

section .data
    len dd 1

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, [n]
    mov ecx, dword[n]
    mov edx, 1
    dec ecx
    GET_UDEC 4, [temp]
    
.L:
    test ecx, ecx
    je .out
    GET_UDEC 4, eax
    cmp eax, dword[temp]
    jng .L1
    inc dword[len]
    jmp .L2
.L1:
    mov ebx, dword[len]
    cmp ebx, edx
    cmovg edx, ebx
    mov dword[len], 1
.L2:
    dec ecx
    mov dword[temp], eax
    test ecx, ecx
    jne .L
    
    mov ebx, dword[len]
    cmp ebx, edx
    cmovg edx, ebx
.out: 
    PRINT_UDEC 4, edx
    xor eax, eax
    ret