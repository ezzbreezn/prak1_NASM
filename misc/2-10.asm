%include "io.inc"

section .bss
    n resd 1
    mx resd 1
section .text
global CMAIN
CMAIN:
    ;write your code here
    GET_DEC 4, [n]
    mov esi, 1
.L:
    cmp esi, dword[n]
    je .EL
    mov eax, esi
    xor edx, edx
    mul esi
    cmp eax, dword[n]
    jg .EL
    mov eax, dword[n]
    xor edx, edx
    div esi
    test edx, edx
    jne .skip
    mov ecx, esi
    cmp eax, dword[n]
    jge .s
    cmp eax, esi
    cmovg ecx, eax
.s:    
    cmp ecx, dword[mx]
    jle .skip
    mov dword[mx], ecx
    
.skip:    
    inc esi
    jmp .L
.EL:
    PRINT_DEC 4, [mx]
    xor eax, eax
    ret