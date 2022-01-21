%include "io.inc"

section .bss
    c resb 1

section .text
global CMAIN
CMAIN:
    call F
    xor eax, eax
    ret
    
F:
    push ebp
    mov ebp, esp
    sub esp, 4
    GET_CHAR cl
    cmp cl, '.'
    je .out 
    movsx ecx, cl
    mov dword[esp], ecx
    call F
    PRINT_CHAR [esp]
    
    
    
.out:    
    mov esp, ebp
    pop ebp
    ret