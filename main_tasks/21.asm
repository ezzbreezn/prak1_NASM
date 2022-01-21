%include "io.inc"

section .rodata
    msg db `%lf`, 0
    
section .bss
    a resd 2
    b resd 2
    
CEXTERN scanf
CEXTERN printf

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 32
    
    mov dword[esp], msg
    lea edx, [esp + 16]
    mov dword[esp + 4], edx
    call scanf
    
    lea edx, [esp + 24]
    mov dword[esp + 4], edx
    call scanf
    
    finit
    
    fld qword[esp + 24]
    fld qword[esp + 16]
    fyl2x
    fld st0
    frndint
    fsub st1, st0
    fxch
    f2xm1
    fld1
    faddp
    fscale
    
    fstp qword[esp + 4]
    mov dword[esp], msg
    call printf
    
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret