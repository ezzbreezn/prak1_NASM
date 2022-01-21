%include "io.inc"

section .bss
    a resd 10

section .text
global CMAIN
CMAIN:
    GET_DEC 4, eax
    cmp eax, 0
    jge .skip
    neg eax
.skip:
    mov ebx, 10
.L:
    test eax, eax
    je .EL
    xor edx, edx
    div ebx
    inc dword[a + 4 * edx]
    jmp .L
.EL:    
    xor ecx, ecx
.L1:
    cmp ecx, 10
    je .EL1
    cmp dword[a + 4 * ecx], 1
    jle .next
    PRINT_DEC 4, ecx
    PRINT_CHAR " "
.next:    
    inc ecx
    jmp .L1
.EL1:            
    xor eax, eax
    ret