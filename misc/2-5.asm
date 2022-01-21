%include "io.inc"

section .bss
    n resd 1
    prev resd 1
    temp resd 1
    ml resd 1
    tl resd 1

section .text
global CMAIN
CMAIN:
    ;write your code here
    GET_UDEC 4, [n]
    xor ecx, ecx
.L:
    cmp ecx, dword[n]
    je .EL
    GET_DEC 4, [temp]
    cmp ecx, 0
    jne .proc
    mov edx, dword[temp]
    mov dword[prev], edx
    mov dword[tl], 1
    inc ecx
    jmp .L
.proc:  
    mov edx, dword[temp]
    cmp edx, dword[prev]  
    jle .res
    inc dword[tl]
    mov dword[prev], edx
    inc ecx
    jmp .L    
.res:
    mov edx, dword[tl]
    cmp edx, dword[ml]
    jle .skip
    mov dword[ml], edx
    mov dword[tl], 1
    mov edx, dword[temp]
    mov dword[prev], edx
    inc ecx
    jmp .L
.skip:
    mov dword[tl], 1
    mov edx, dword[temp]
    mov dword[prev], edx
    inc ecx
    jmp .L              
                                  
.EL:  
    mov edx , dword[tl]
    cmp edx, dword[ml]
    jle .ans
    mov dword[ml], edx
.ans:                 
    PRINT_UDEC 4, [ml]               
    xor eax, eax
    ret