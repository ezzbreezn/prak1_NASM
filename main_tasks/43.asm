%include "io.inc"

section .bss
    n resd 1
    a resd 1
    

section .text
global CMAIN
CMAIN:
    
    ;write your code here
    GET_UDEC 4, [n]
    xor ecx, ecx
.l:
    cmp ecx, dword[n]
    je .el
    GET_UDEC 4, [a]
    push dword[a]
    inc ecx
    jmp .l
.el: 
    mov ecx, 1
    add esp, 4
.l1:
    cmp ecx, dword[n]
    je .el1
    mov edx, dword[esp]
    cmp edx, dword[esp -4]
    jge .neg
    add esp, 4
    inc ecx
    jmp .l1
.neg:
    xor eax, eax
    mov ebx, dword[n]
    sub ebx, ecx
    sal ebx, 2
    add esp, ebx
    jmp .ans
.el1:
    cmp ecx, dword[n]
    jne .ans
    mov eax, 1
.ans:
    PRINT_UDEC 4, eax
    
    

    xor eax, eax
    ret