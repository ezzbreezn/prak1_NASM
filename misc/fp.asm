%include "io.inc"

section .rodata
    msgi db `%lf`, 0
    msgo db `%.12lf\n`, 0    
    
CEXTERN scanf
CEXTERN printf
    
section .text
global CMAIN
CMAIN:  
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 32
    
    mov dword[esp], msgi
    lea ecx, [esp + 16]
    mov dword[esp + 4], ecx
    call scanf
    
    finit
    fld1
    fld qword[esp + 16]
    fdivp
    fstp qword[esp + 16]
    
    mov dword[esp], msgo
    mov edx, dword[esp + 16]
    mov dword[esp + 4], edx
    mov edx, dword[esp + 20]
    mov dword[esp+ 8], edx
    call printf
    
    
    
    
    
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret