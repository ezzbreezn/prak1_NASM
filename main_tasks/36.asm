%include "io.inc"

section .bss
    n resd 1

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    
    GET_DEC 4, [n]
    
    mov edx, dword[n]
    xor ecx, ecx
.L:
    cmp ecx, dword[n]
    je .EL
    GET_DEC 4, edx
    push edx
    inc ecx
    jmp .L
.EL:    
    mov ecx, dword[n]
    dec ecx
    pop edx
.L1:
    cmp ecx, 0
    je .EL1
    pop eax
    push edx
    mov edx, eax
    add esp, 4
    dec ecx
    jmp .L1
    
.EL1:    
    mov ecx, dword[n]
    dec ecx
    sal ecx, 2
    sub esp, ecx
    push edx
    
    xor ecx, ecx
    
.L2:
    cmp ecx, dword[n]
    je .EL2
    PRINT_DEC 4, [esp + 4 * ecx]
    NEWLINE
    inc ecx
    jmp .L2
    
.EL2:
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret