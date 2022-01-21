%include "io.inc"

section .rodata
    msg db `%d`, 0
    
CEXTERN scanf
CEXTERN printf

section .bss
    a resd 1

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msg
    mov dword[esp + 4], a
    call scanf

    mov edx, dword[a]
    mov dword[esp], edx
    call F

    
    mov dword[esp], msg
    mov dword[esp + 4], eax
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
    mov dword[esp + 12], 0
    cmp dword[ebp + 8], 0
    jle .triv
    cmp dword[ebp + 8], 1
    je .triv
    cmp dword[ebp + 8], 2
    je .triv
    
    mov edx, dword[ebp + 8]
    sub edx, 2
    mov dword[esp], edx
    call F
    
    add dword[esp + 12], eax
    
    mov edx, dword[ebp + 8]
    sub edx, 3
    mov dword[esp], edx
    call F
    
    add eax, dword[esp + 12]
    jmp .out
.triv:
    mov eax, 1    
    
    
.out:    
    mov esp, ebp
    pop ebp
    ret