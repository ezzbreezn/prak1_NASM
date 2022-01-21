%include "io.inc"

section .rodata
    msgi db `%lf`, 0
    msgo db `%.3lf`, 0
    
section .bss
    a resd 2
    b resd 2
    c resd 2
    
section .data
    two dd 2.0        
                

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 32
    
    mov dword[esp], msgi
    mov dword[esp + 4], a
    call scanf
    
    mov dword[esp], msgi
    mov dword[esp + 4], b
    call scanf
    
    mov dword[esp], msgi
    mov dword[esp + 4], c
    call scanf
    
    
    
    finit
    fld qword[a]
    fld qword[b]
    fld qword[c]
    faddp
    faddp
    fld dword[two]
    fdivp
    fst qword[esp]
    fld qword[esp]
    fld qword[a]
    fsubp
    fld qword[esp]
    fld qword[b]
    fsubp
    fld qword[esp]
    fld qword[c]
    fsubp
    fmulp
    fmulp
    fmulp
    fsqrt
    fstp qword[esp + 16]
    
    mov edx, dword[esp + 16]
    mov dword[esp + 4], edx
    mov edx, dword[esp + 20]
    mov dword[esp + 8], edx
    mov dword[esp], msgo
    call printf
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret