%include "io.inc"

section .bss
    n resd 1
    k resd 1
    ans resd 1
    max resd 1
    temp resd 1

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, [n]
    GET_UDEC 4, [k]
    mov dword[ans], 1
    mov ecx, 1
    xor edx, edx
.L:
    cmp edx, dword[k]
    je .EL
    or dword[ans], ecx
    shl ecx, 1
    inc edx
    jmp .L        
.EL:    
    mov edx, 32
    sub edx, dword[k]
    inc edx
    xor ecx, ecx
.L2:
    cmp ecx, edx
    je .EL2
    mov eax, dword[ans]
    and eax, dword[n]
    shr eax, cl
    cmp eax, dword[max]
    jle .n
    mov dword[max], eax
.n:
    inc ecx
    mov eax, dword[ans]
    shl eax, 1
    mov dword[ans], eax
    jmp .L2    
.EL2:   
    PRINT_UDEC 4, [max]         
    xor eax, eax
    ret