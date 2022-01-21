%include "io.inc"

section .text
global CMAIN
CMAIN:
    ;write your code here
    call F
    xor eax, eax
    ret
    
    
F:
    push ebp
    mov ebp, esp
    sub esp, 4
    
    
    GET_DEC 4, ecx
    test ecx, ecx
    je .out
    cmp ecx, 0
    jge .nc
    PRINT_DEC 4, ecx
    NEWLINE
    call F
    jmp .out
.nc:
    mov dword[esp], ecx
    call F
    PRINT_DEC 4, [esp]
    NEWLINE    
    
.out:    
    mov esp, ebp
    pop ebp
    ret
    