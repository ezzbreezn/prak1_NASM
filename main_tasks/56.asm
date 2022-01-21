%include "io.inc"

section .rodata
    msgf db `%lf`, 0
    fin db `/home/boris/prak/asm/sassasm/input.bin`, 0
    rmode db `rb` ,0
    
    
CEXTERN scanf
CEXTERN printf
CEXTERN fopen
CEXTERN fclose
CEXTERN fread

section .bss
    temp resd 2
    n resd 1
    f resd 1

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    mov dword[esp], fin
    mov dword[esp + 4], rmode
    call fopen

    mov dword[f], eax
    
    finit
    xor edi, edi
    
.L:
    mov dword[esp], temp
    mov dword[esp + 4], 8
    mov dword[esp + 8], 1
    mov edx, dword[f]
    mov dword[esp + 12], edx
    call fread
    
    cmp eax, 0
    je .EL
    
    fld qword[temp]
    cmp edi, 0
    je .skip
    fmulp
.skip:    
    inc edi
    inc dword[n]
    jmp .L
.EL:      
    
    mov edx, dword[f]
    mov dword[esp], edx
    call fclose
    
    fldz
    fucomip
    je .out
    
    fld1
    fild dword[n]
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
    
.out:    
    fstp qword[esp + 4]
    mov dword[esp], msgf
    call printf



    mov esp, ebp
    pop ebp
    xor eax, eax
    ret