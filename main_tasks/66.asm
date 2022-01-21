%include "io.inc"

section .rodata
    msg db `%d`, 0
    
CEXTERN scanf
CEXTERN printf

section .bss
    a resd 10000
    s resd 1
    n resd 1

section .text
global CMAIN
CMAIN:
    ;write your code here
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msg
    mov dword[esp + 4], n
    call scanf
    
    xor edi, edi
.L: 
    cmp edi, dword[n]
    je .EL
    
    mov dword[esp], msg
    lea edx, [a + 4 * edi]
    mov dword[esp + 4], edx
    call scanf
    
    inc edi
    jmp .L
.EL:    
    mov ecx, a
    mov edx, dword[n]
    call F


    mov dword[esp], msg
    mov dword[esp + 4], eax
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
    xor eax, eax
    xor edi, edi
.L:
    cmp edi, edx
    je .EL
    add eax, dword[ecx + 4 * edi]
    inc edi
    jmp .L
.EL:    
    
    mov esp, ebp
    sub esp, 4
    pop edi
    pop ebp
    ret