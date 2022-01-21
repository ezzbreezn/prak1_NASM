%include "io.inc"

section .rodata
    msg db `%lf`, 0

CEXTERN scanf
CEXTERN printf

section .bss
    a resd 2
    b resd 2

section .text
global CMAIN
CMAIN:
    ;write your code here
    push ebp
    mov ebp, esp
    sub esp, 12
    
    mov dword[esp], msg
    mov dword[esp + 4], a
    call scanf
    
    mov dword[esp + 4], b
    call scanf
    
    finit
    fld qword[a]
    fld qword[b]
    fucomip
    jbe .n1
    PRINT_CHAR 'B'
    jmp .out
.n1:
    PRINT_CHAR `A`
.out:
    
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret