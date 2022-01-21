%include "io.inc"

section .rodata
    msgi db `%lf`, 0
    msg db `%d`, 0

section .bss
    n resd 1
    arr resd 1

CEXTERN scanf
CEXTERN printf
CEXTERN malloc

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msg
    mov dword[esp + 4], n
    call scanf
    
    
    mov edx, dword[n]
    sal edx, 3
    mov dword[esp], edx
    call malloc
    mov dword[arr], eax
    
    mov edi, dword[arr]
    xor esi, esi
    
.l:
    cmp esi, dword[n]
    je .el
    mov dword[esp], msgi
    lea edx, [edi + 8 * esi]
    mov dword[esp + 4], edx
    call scanf
    inc esi
    jmp .l
.el:

    mov edx, dword[n]
    mov dword[esp], edx
    mov edx, dword[arr]
    mov dword[esp + 4], edx
    call PCR
    
    fstp qword[esp + 4]
    
    mov dword[esp], msgi
    ;mov edx, dword[esp + 8]
    ;mov dword[esp + 4], edx
    ;mov edx, dword[esp + 12]
    ;mov dword[esp + 8], edx
    call printf
    
    
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    xor eax, eax
    ret
    
PCR:
    push ebp
    mov ebp, esp
    push esi
    push edi
    and esp, ~15
    sub esp, 16
    
    xor esi, esi
    mov edi, dword[ebp + 12]
    finit
    
.L:
    cmp esi, dword[ebp + 8]
    je .EL
    fld1
    fld qword[edi + 8 * esi]
    fdivp
    test esi, esi
    je .skip
    faddp
.skip:
    inc esi
    jmp .L
.EL:        
            
    mov esp, ebp
    sub esp, 8
    pop edi
    pop esi
    pop ebp
    ret                