%include "io.inc"

section .rodata
    msgf db `%f` ,0
    msgd db `%d`, 0
    msgo db `%.3f`, 0
    
CEXTERN scanf
CEXTERN printf

section .bss
    a resd 1
    b resd 1
    s resd 1

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msgf
    mov dword[esp + 4], a
    call scanf
    
    mov dword[esp], msgd
    mov dword[esp + 4], b
    call scanf
    
    mov edx, dword[a]
    mov dword[esp], edx
    mov edx, dword[b]
    mov dword[esp + 4], edx
    call F
    
    ;finit
    ;fld dword[a]
    cmp dword[s], 1
    jne .skip
    fchs
.skip:    
    fstp qword[esp + 4]
   ; fstp dword[esp + 4]
   ;mov edx, dword[a]
   ;mov dword[esp + 4], edx
    mov dword[esp], msgf
    call printf
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
    
F:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    finit
    
    fld dword[ebp + 8]
    fldz
    fucomip
    jbe .skip
    mov edx, dword[ebp + 12]
    test edx, 1
    je .c
    mov dword[s], 1
    jmp .c
.c:
    finit    
    fild dword[ebp + 12]
    fld dword[ebp + 8]
    fchs
    jmp .end
    
.skip:
    finit    
.nc:    
    fild dword[ebp + 12]
    fld dword[ebp + 8]
    jmp .end
.end:
    fyl2x
    fld st0
    frndint
    fsub st1, st0
    fxch
    f2xm1
    fld1
    faddp
    fscale
    fstp st1
    
    
    mov esp, ebp
    pop ebp
    ret