%include "io.inc"

section .rodata
    msg db `%lf`, 0
    
section .bss
    x1 resd 2
    y1 resd 2
    x2 resd 2
    y2 resd 2
    x3 resd 2
    y3 resd 2
    
CEXTERN scanf
CEXTERN printf    

section .text
global CMAIN
CMAIN:
    ;mov ebp, esp; for correct debugging
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msg
    mov dword[esp + 4], x1
    call scanf
    
    mov dword[esp], msg
    mov dword[esp + 4], y1
    call scanf
    
    mov dword[esp], msg
    mov dword[esp + 4], x2
    call scanf    
    
    mov dword[esp], msg
    mov dword[esp + 4], y2
    call scanf    
    
    mov dword[esp], msg
    mov dword[esp + 4], x3
    call scanf
        
    mov dword[esp], msg
    mov dword[esp + 4], y3
    call scanf        
    
    finit
    
    fld qword[x1]
    fld qword[x3]
    fsubp
    fld qword[y2]
    fld qword[y3]
    fsubp
    fmulp
    fld qword[y1]
    fld qword[y3]
    fsubp
    fld qword[x2]
    fld qword[x3]
    fsubp
    fmulp
    fsubp
    fld1
    fld1
    faddp
    fdivp
    fabs
 
    fstp qword[esp + 4]
    mov dword[esp], msg
    call printf    
     
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret