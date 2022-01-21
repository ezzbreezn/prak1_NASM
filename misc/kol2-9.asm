%include "io.inc"

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    sub esp, 16
    
    mov eax, 0xff00
    add ah, 0xcd
    PRINT_HEX 4, eax
    
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret