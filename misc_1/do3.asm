%include "io.inc"

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    
    GET_DEC 4, eax
    push eax
    call F
    
    PRINT_DEC 4, eax
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
    
F:
    cmp dword[esp + 4], 0
    je .R
    mov edx, dword[esp + 4]
    dec edx
    push edx
    call F
    xor edx, edx
    mul dword[esp + 8]
    add esp, 4
    jmp .RET
.R:
    mov eax, 1
.RET:
    ret            