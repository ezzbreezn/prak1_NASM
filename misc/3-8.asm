%include "io.inc"

section .bss
    n resd 1
    k resd 1
    sum resd 1

section .text
global CMAIN
CMAIN:
    ;write your code here
    GET_UDEC 4, [n]
    GET_DEC 4, [k]
    mov edx, dword[n]
    add dword[sum], edx
.L:
    push dword[k]
    push dword[n]
    call F
    add esp, 8
    add dword[sum], eax
    cmp eax, dword[n]
    je .EL
    mov dword[n], eax
    jmp .L
.EL:
    PRINT_UDEC 4, [sum]
    
    xor eax, eax
    ret
    
    
F:
    push ebp
    mov ebp, esp

    xor ecx, ecx
    mov eax, dword[ebp + 8]
.L: 
    cmp eax, 0
    je .EL
    xor edx, edx
    div dword[ebp + 12]
    add ecx, edx
    jmp .L
.EL:    
    mov eax, ecx
    mov esp, ebp
    pop ebp
    ret