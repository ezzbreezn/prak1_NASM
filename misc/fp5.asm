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
    lea edx, [esp + 8]
    mov dword[esp + 4], edx
    call scanf
    
    mov dword[esp], msg
    lea edx, [esp + 16]
    mov dword[esp + 4], edx
    call scanf
    
    mov dword[esp], msg
    lea edx, [esp + 24]
    mov dword[esp + 4], edx
    call scanf
    
    mov edx, dword[esp + 8]
    mov dword[esp], edx
    mov edx, dword[esp + 12]
    mov dword[esp + 4], edx
    mov edx, dword[esp + 16]
    mov dword[esp + 8], edx
    mov edx, dword[esp + 20]
    mov dword[esp + 12], edx
    mov edx, dword[esp + 24]
    mov dword[esp + 16], edx
    mov edx, dword[esp + 28]
    mov dword[esp + 20], edx
    call lawofsin
    
    fstp qword[esp + 16]
    
    mov dword[esp], msg
    mov edx, dword[esp + 16]
    mov dword[esp + 4], edx
    mov edx, dword[esp + 20]
    mov dword[esp + 8], edx
    call printf
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
lawofsin:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 32
        
    finit
    fld qword[ebp + 8]
    fld qword[ebp + 24]
    fsin
    fmulp
    fld qword[ebp + 16]
    fsin
    fdivp    
            
    mov esp, ebp
    pop ebp
    ret    