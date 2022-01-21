%include "io.inc"

section .bss
    x resd 1
    a resd 1000
    n resd 1
section .text
global CMAIN
CMAIN:
    GET_UDEC 4, [x]
    mov ebx, 8
    cmp dword[x], 0
    jne .L
    PRINT_DEC 4, [x]
    jmp .EL2
.L:
    cmp dword[x], 0
    je .EL
    mov eax, dword[x]
    xor edx, edx
    div ebx
    mov ecx, dword[n]
    mov dword[a + 4 * ecx], edx
    mov dword[x], eax
    inc dword[n]
    jmp .L
.EL:      
    
.L2:
    cmp dword[n], 0
    je .EL2
    mov ecx, dword[n]
    PRINT_DEC 4, [a + 4 * ecx - 4]
    dec dword[n]
    jmp .L2
                    
.EL2:                                                    
    xor eax, eax
    ret