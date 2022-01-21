%include "io.inc"

section .rodata
    msg db `%lf`, 0
    msgi db `%d`, 0
    
    
CEXTERN scanf
CEXTERN printf


section .bss
    a resd 200
    n resd 1

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    push edi
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msgi
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
    push dword[n] 
    push a
    call F
    add esp, 8
    mov dword[esp], msgi
    mov dword[esp + 4], eax
    call printf
    mov esp, ebp
    sub esp, 4
    pop edi
    pop ebp
    xor eax, eax
    ret
    
F:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    xor eax, eax
    mov edx, dword[ebp + 8]
    finit
    fld qword[edx]
    add edx, 8
    mov ecx, 1
.L:
    cmp ecx, dword[ebp + 12]
    je .EL
    fld qword[edx]
    fucomip st0, st1
    jbe .skip
    inc eax
.skip:
    inc ecx
    add edx, 8
    jmp .L        
.EL:     
    finit   
    mov esp, ebp
    pop ebp
    ret            