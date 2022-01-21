%include "io.inc"

section .bss
     m resd 1
     n resd 1
     temp resd 1
     t resd 1

section .data
    mod dd 10

section .text
global CMAIN
CMAIN:
    ;write your code here
    GET_UDEC 4, [m]
    GET_UDEC 4, [n]
    xor edi, edi
.L:
    cmp edi, dword[n]
    je .EL
    push dword[m]
    call REVERSE
    add esp, 4
    add dword[m], eax
    inc edi
    jmp .L
    
    
.EL:
    push dword[m]
    call REVERSE
    add esp, 4
    cmp eax, dword[m]
    jne .neg
    PRINT_STRING 'Yes'
    NEWLINE
    PRINT_UDEC 4, [m]
    jmp .out
.neg:
    PRINT_STRING 'No'
.out:    
    xor eax, eax
    ret
    
REVERSE:
    push ebp
    mov ebp, esp
    push ebx
    xor ebx, ebx
    mov eax, dword[ebp + 8]
.l:
    test eax, eax    
    je .el
    xor edx, edx
    div dword[mod]
    mov dword[temp], eax
    mov dword[t], edx
    mov eax, ebx
    xor edx, edx
    mul dword[mod]
    mov ebx, eax
    add ebx, dword[t]
    mov eax, dword[temp]
    jmp .l
.el:    
    mov eax, ebx
    mov esp, ebp
    pop ebp
    ret
