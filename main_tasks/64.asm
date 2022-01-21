%include "io.inc"


section .rodata
    msg db `%d`, 0
    
    
CEXTERN scanf
CEXTERN printf

section .bss
    n resd 1

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msg
    mov dword[esp + 4], n
    call scanf
    
    mov edx, dword[n]
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
    sub esp, 16
    cmp dword[esp + 20], 0
    jne .n
    mov eax, 1
    jmp .out
.n:
    mov edx, dword[esp + 20]
    dec edx
    mov dword[esp], edx
    call F
    xor edx, edx
    mul dword[esp + 20]    
    
.out:    
    add esp, 16
    ret
    
    
    