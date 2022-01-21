%include "io.inc"

section .rodata
    msg db `%lf`, 0
    msgd db `%d`, 0
    
section .bss
    a resd 1000
    n resd 1
 
 
CEXTERN scanf
CEXTERN printf

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msgd
    mov dword[esp + 4], n
    call scanf
    
    xor edi, edi
.L: 
    cmp edi, dword[n]
    je .EL
    mov dword[esp], msg
    lea edx, [a + 8 * edi]
    mov dword[esp + 4], edx
    call scanf
    
    inc edi
    jmp .L
.EL:    
    mov edx, dword[n]
    test edx, 1
    je .skip
    inc edx
.skip:
    sal edx, 3
    sub esp, edx
    
    xor edi, edi
.L1:
    cmp edi, dword[n]
    je .EL1
    mov edx, dword[a + 8 * edi]
    mov ecx, dword[a + 8 * edi + 4]
    mov dword[esp + 8 * edi + 4], edx
    mov dword[esp + 8 * edi + 8], ecx
    inc edi
    jmp .L1
    
.EL1: 
    mov edx, dword[n]
    mov dword[esp], edx    
    call F
    ;PRINT_STRING `HUI\n`
    fstp qword[esp + 4]
    mov dword[esp], msg
    call printf   
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    xor eax, eax
    ret
    
F:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    finit
    
    ;mov dword[esp], msg
    ;mov edx, dword[ebp + 12]
    ;mov ecx, dword[ebp + 16]
    ;mov dword[esp + 4], edx
    ;mov dword[esp + 8], ecx
    ;call printf
    ;NEWLINE
    
    xor edi, edi
    
.L:
    cmp edi, dword[ebp + 8]
    je .EL
    fld qword[ebp + 8 * edi + 12]
    inc edi
    cmp edi, 1
    je .ni
    fmulp
.ni:
    jmp .L    
    
.EL:  


    fld1
    fild dword[ebp + 8]
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
   
    
    
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    ret