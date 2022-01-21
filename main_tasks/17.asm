%include "io.inc"

section .rodata
    msg db `%lf`, 0
    
    
section .bss
    n resd 2

CEXTERN scanf
CEXTERN printf

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msg
    mov dword[esp + 4], n
    call scanf
    
    finit
    
    fld qword[n]
    fldl2e
    fmulp 
    fld st0
    frndint
    fsub st1, st0
    fxch
    f2xm1
    fld1
    faddp
    fscale
    fstp st1
    
    fstp qword[esp + 4]
    mov dword[esp], msg
    call printf
    
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    
    xor eax, eax
    ret