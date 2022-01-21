%include "io.inc"

section .rodata
    msg db `%lf`, 0
    
section .bss
     a resd 1
     
CEXTERN scanf
CEXTERN printf


section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msg
    mov dword[esp + 4], a
    call scanf
    
    finit
    fld1
    fld qword[a]
    fdivp
    
    fstp qword[esp + 4]
    mov dword[esp], msg
    call printf
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret