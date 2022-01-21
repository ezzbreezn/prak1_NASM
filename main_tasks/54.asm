%include "io.inc"

section .rodata
    msgf db `%f` ,0
    msgo db `%.3f`, 0
    
CEXTERN scanf
CEXTERN printf

section .bss
    a resd 1
    b resd 1

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
    
    mov dword[esp], msgf
    mov dword[esp + 4], b
    call scanf
    
    mov edx, dword[a]
    mov dword[esp], edx
    mov edx, dword[b]
    mov dword[esp + 4], edx
    call F
    
    ;finit
    ;fld dword[a]
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
    
    
    
    fld dword[ebp + 12]
    fld dword[ebp + 8]
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