%include "io.inc"

section .rodata
    msgi db `%d`, 0
    msgd db `%lf`, 0
    
CEXTERN scanf
CEXTERN printf

section .bss
    n resd 1

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    push edi
    and esp, ~15
    sub esp, 32
    
    mov dword[esp], msgi
    lea edx, [ebp - 4]
    mov dword[esp + 4], edx
    call scanf
    
    mov edi, dword[ebp - 4]
    
    finit
    
.L:
    test edi, edi
    je .EL
    
    mov dword[esp], msgd
    lea edx, [esp + 16]
    mov dword[esp + 4], edx
    call scanf
    
    mov dword[esp], msgd
    lea edx, [esp + 24]
    mov dword[esp + 4], edx
    call scanf
    
    fld qword[esp + 16]
    fld qword[esp + 24]
    fmulp
    cmp edi, dword[ebp - 4]
    je .skip
    faddp
.skip:
    dec edi
    jmp .L
.EL:       
    fstp qword[esp + 4]
    mov dword[esp], msgd
    call printf
    
    
    mov esp, ebp
    sub esp, 4
    pop edi
    pop ebp
    xor eax, eax
    ret