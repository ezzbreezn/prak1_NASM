%include "io.inc"

section .rodata
    msg db `%lf`, 0
    
CEXTERN scanf
CEXTERN printf


section .bss
    a resd 2
    x resd 2

section .text
global CMAIN
CMAIN:
    ;write your code here
    push ebp
    mov ebp, esp
    sub esp, 24
    
    mov dword[esp], msg
    mov dword[esp + 4], x
    call scanf
    
    mov dword[esp + 4], a
    call scanf
    
    mov ecx, dword[x]
    mov dword[esp], ecx
    mov ecx, dword[x + 4]
    mov dword[esp + 4], ecx
    mov ecx, dword[a]
    mov dword[esp+ 8], ecx
    mov ecx, dword[a + 4]
    mov dword[esp + 12], ecx
    call f
    
    fstp qword[esp + 4]
    mov dword[esp], msg
    call printf
    
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
    
f:
    push ebp
    mov ebp, esp
    sub esp, 12
    
    finit
    fld qword[ebp + 16]
    fld qword[ebp + 8]
    fyl2x
    fld qword[ebp + 16]
    fld qword[ebp + 16]
    fyl2x
    fdivp
    
    
    mov esp, ebp
    pop ebp
    ret