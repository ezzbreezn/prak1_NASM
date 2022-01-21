%include "io.inc"

section .rodata
    msgi db `%lf`, 0
    msgo db `%lf %lf`, 0


section .bss
    x resd 2
    y resd 2
    
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
    mov dword[esp + 4], x
    call scanf
    
    mov dword[esp], msgi
    mov dword[esp + 4], y
    call scanf
    
    mov edx, dword[x]
    mov dword[esp], edx
    mov edx, dword[x + 4]
    mov dword[esp + 4], edx
    mov edx, dword[y]
    mov dword[esp + 8], edx
    mov edx, dword[y + 4]
    mov dword[esp + 12], edx
    call FPTC
    
    fstp qword[esp]
    fstp qword[esp + 8]
    
    mov edx, dword[esp + 8]
    mov dword[x], edx
    mov edx, dword[esp + 12]
    mov dword[x + 4], edx
    
    mov edx, dword[esp]
    mov dword[y], edx
    mov edx, dword[esp + 4]
    mov dword[y + 4], edx
    
    mov dword[esp], msgo
    mov edx, dword[x]
    mov dword[esp + 4], edx
    mov edx, dword[x + 4]
    mov dword[esp + 8], edx
    mov edx, dword[y]
    mov dword[esp + 12], edx
    mov edx, dword[y + 4]
    mov dword[esp + 16], edx
    call printf
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
    
FPTC:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    finit 
    fld qword[ebp + 16]
    fld qword[ebp + 8]
    fpatan
    fld qword[ebp + 16]
    fldz
    fucomip st1
    jc .skip
    fstp qword[ebp + 16]
    fldpi
    faddp
    fldpi
    faddp
    jmp .next
.skip:
    fstp qword[ebp + 16]
.next:
    fld qword[ebp + 8]
    fld qword[ebp + 8]
    fmulp
    fld qword[ebp + 16]
    fld qword[ebp + 16]
    fmulp
    faddp
    fsqrt
    
        
    mov esp, ebp
    pop ebp
    ret    