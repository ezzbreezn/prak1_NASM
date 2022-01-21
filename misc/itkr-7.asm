%include "io.inc"

section .rodata
    msg db `%c` ,0
    p db `YES`, 0
    np db `NO`, 0
    
    
CEXTERN scanf
CEXTERN printf


section .bss
    a resd 26
    c resb 1

section .text
global CMAIN
CMAIN:
    ;write your code here
    push ebp
    mov ebp, esp
    sub esp, 8
    
.L:
    mov dword[esp], msg
    mov dword[esp + 4], c
    call scanf
    
    cmp byte[c], '.'
    je .EL
    xor ecx, ecx
    mov cl, byte[c]
    sub cl, 'a'
    inc dword[a + 4 * ecx]
    jmp .L    
    
.EL:    

    xor eax, eax
    xor ecx, ecx
.L1:
    cmp eax, 1
    je .EL1
    cmp ecx, 26
    je .EL1
    cmp dword[a + 4 * ecx], 2
    jl .skip
    mov eax, 1
.skip:
    inc ecx
    jmp .L1    

.EL1:
    cmp eax, 1
    je .P
    mov dword[esp], np
    call printf
    jmp .out
.P:
    mov dword[esp], p
    call printf
.out:
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret