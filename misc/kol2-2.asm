%include "io.inc"

section .rodata
    msg db `%lf%lf%lf`, 0
    msg1 db `%lf`, 0    
CEXTERN printf
CEXTERN scanf

section .data
    x dd 3.1415

section .bss
    a resd 2
    b resd 2
    c resd 2

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    sub esp, 32
    
    mov dword[esp], msg
    lea ecx, [esp + 16]
    mov dword[esp + 4], ecx
    add ecx, 8
    mov dword[esp + 8], ecx
    add ecx, 8
    mov dword[esp + 12], ecx
    ;mov dword[esp + 4], a
    ;mov dword[esp + 8], b
    ;mov dword[esp + 12], c
    call scanf
    add esp, 16
    
    ;mov ecx, dword[a]
    ;mov dword[esp], ecx
    ;mov ecx, dword[a + 4]
    ;mov dword[esp + 4], ecx
    ;mov ecx, dword[b]
    ;mov dword[esp + 8], ecx
    ;mov ecx, dword[b + 4]
    ;mov dword[esp + 12], ecx
    ;mov ecx, dword[c]
    ;mov dword[esp + 16], ecx
    ;mov ecx, dword[c + 4]
    ;mov dword[esp + 20], ecx
    
    call F
    
    mov dword[esp], msg1
    fstp qword[esp + 4]
    call printf
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
F:
    finit
    fld qword[esp + 4]
    fsin
    fld dword[x]
    fld qword[esp + 12]
    fmulp
    fsubp
    fld qword[esp + 20]
    fcos
    faddp
    ret