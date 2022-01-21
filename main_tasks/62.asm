%include "io.inc"

section .rodata
    msg db `%lf`, 0
    msgo db `%lf %lf\n`, 0
    msgd db `%d`, 0
CEXTERN scanf
CEXTERN printf


section .bss
    n resd 1
    x resd 2

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
    
    mov edx, dword[n]
    inc edx
    sal edx, 3
    sub esp, edx
    
    xor edi, edi
.L: 
    cmp edi, dword[n]
    je .EL
    mov dword[esp], msg
    lea edx, [esp + 8 * edi + 8]
    mov dword[esp + 4], edx
    call scanf
    
    inc edi
    jmp .L
    
.EL:    
    mov edx, dword[n]

    mov dword[esp], edx
    mov dword[esp + 4], printf
    call F

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
    sub esp, 32
    
    finit
    
    xor edi, edi
.L:
    cmp edi, dword[ebp + 8]
    je .EL
          
    finit
    fld1
    fld qword[ebp + 8 * edi + 16 ]
    fdivp
    fstp qword[esp + 4] 
    inc edi
    fld1
    fld qword[ebp + 8 * edi + 16]
    fdivp
    fstp qword[esp + 12]
    inc edi
    mov dword[esp], msgo
    call dword[ebp + 12]
    jmp .L   
                
.EL:                
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    ret  
    