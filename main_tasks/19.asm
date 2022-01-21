%include "io.inc"

section .rodata
    msg db `%lf`, 0
    msgd db `%d`, 0
    
section .bss
    a resd 2
    b resd 2

CEXTERN scanf
CEXTERN printf

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msg
    mov dword[esp + 4], a
    call scanf
    
    mov dword[esp], msg
    mov dword[esp + 4], b
    call scanf
    
    finit
    
    fld qword[b]
    fld qword[a]
    
    fucomip
    
    ja .pos
    je .eq
    mov eax, -1
    jmp .out
.pos:
    mov eax, 1
    jmp .out
.eq:
    xor eax, eax
.out:

    mov dword[esp], msgd
    mov dword[esp + 4], eax
    call printf
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret