%include "io.inc"

section .rodata
    msg db `%lf`, 0
    
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
    
    mov dword[esp], msg
    lea edx, [esp + 24]
    mov dword[esp + 4], edx
    call scanf
    
    finit
    fld qword[esp + 24]
    fld qword[esp + 16]
    fscale
    fstp st1
    fstp qword[esp + 4]
    mov dword[esp], msg
    call printf
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret