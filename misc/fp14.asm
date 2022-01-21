%include "io.inc"

section .rodata 
    fin db `/home/boris/data.bin`, 0
    rmode db `rb`, 0
    msg db `%lf`, 0
    
CEXTERN fread
CEXTERN fopen
CEXTERN fclose
CEXTERN printf
    
section .bss
    f resd 1 
    cnt resd 1 
    
        

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 32
    
    mov dword[esp], fin
    mov dword[esp + 4], rmode
    call fopen
    
    mov dword[f], eax
    
    finit
    
.L:
    lea edx, [esp + 16]
    mov dword[esp], edx
    mov dword[esp + 4], 8
    mov dword[esp + 8], 1
    mov edx, dword[f]
    mov dword[esp + 12], edx
    call fread
    
    test eax, eax
    je .EL
    
    inc dword[cnt]
    fld qword[esp + 16]
    cmp dword[cnt], 1
    je .skip
    fmulp
.skip:
    jmp .L
.EL:
    
    mov edx, dword[f]
    mov dword[esp], edx
    call fclose
    
    fld1
    fild dword[cnt]
    fdivp
    
    fxch
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

    
    fstp qword[esp + 4]
    mov dword[esp], msg
    call printf
        
        
    
    mov esp, ebp
    sub esp, 4
    pop edi
    pop ebp
    xor eax, eax
    ret