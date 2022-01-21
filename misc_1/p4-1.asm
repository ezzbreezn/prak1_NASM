%include "io.inc"

section .rodata
    msgi db `%u`, 0
    msgo db `0x%08X\n`, 0
    
CEXTERN scanf
CEXTERN printf    

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    push ebx
    and esp, ~15
    sub esp, 16
    lea ebx, [esp + 12]
    mov dword[esp + 4], ebx
    mov dword[esp], msgi
.L:
    call scanf
    cmp eax, -1
    je .EL    
    sub esp, 16
    mov ebx, dword[esp + 28]      
    mov dword[esp + 4], ebx
    mov dword[esp], msgo
    call printf
    add esp, 16
    jmp .L            
.EL:       
    mov esp, ebp
    sub esp, 4
    pop ebx
    pop ebp
    xor eax, eax
    ret