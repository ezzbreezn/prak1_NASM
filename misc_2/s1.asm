%include "io.inc"

section .rodata
    msg db `%.3lf`, 0

section .data
    a dd -15.123
    b dd 1.5678
    
section .bss
    c resd 1    
    
CEXTERN printf    

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    finit
    fld dword[a]
    fld dword[b]
    faddp
    
    fst dword[c]
    
    PRINT_HEX 4, [c]
    NEWLINE
    
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msg
    fstp qword[esp + 4]
    call printf 
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret