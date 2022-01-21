%include "io.inc"

section .rodata
    msgi db `%le`, 0
    msgo db `%.3lf`, 0
    
section .data
    two dd 2.0
    
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
    lea edx, [esp + 16]
    mov dword[esp + 4], edx
    call scanf
    
    finit
    fld qword[esp + 16]
    fldpi
    fmulp 
    mov edx, dword[two]
    fld dword[two]
    fmulp
    fstp qword[esp + 16]
    
    
    mov dword[esp], msgo
    mov edx, dword[esp + 16]
    mov dword[esp + 4], edx
    mov edx, dword[esp + 20]
    mov dword[esp + 8], edx
    call printf
    
    
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret