%include "io.inc"

section .rodata
    msg db `%s`, 0
    
CEXTERN scanf
CEXTERN printf
CEXTERN strcmp

section .bss
    s1 resb 101
    s2 resb 101
    
                    

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msg
    mov dword[esp + 4], s1
    call scanf
    
    mov dword[esp], msg
    mov dword[esp + 4], s2
    call scanf
    
    mov dword[esp], s1
    mov dword[esp + 4], s2
    call strcmp
    
    cmp eax, 0
    jle .L
    mov dword[esp], msg
    mov dword[esp + 4], s1
    call printf
    jmp .out
.L:
    mov dword[esp], msg
    mov dword[esp + 4], s2
    call printf
.out:   
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret