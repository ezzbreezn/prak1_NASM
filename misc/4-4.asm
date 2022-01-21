%include "io.inc"

section .rodata
    fin db `data.in`, 0
    rmode db `r`, 0
    msg db `%d`, 0
    
CEXTERN fopen
CEXTERN fclose
CEXTERN printf
CEXTERN fscanf

section .bss
    f resd 1
    s resd 1
    x resd 1     
    
section .text
global CMAIN
CMAIN:
    ;write your code here
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], fin
    mov dword[esp + 4], rmode
    call fopen
    
    mov dword[f], eax
    
.L:
    mov edx, dword[f]
    mov dword[esp], edx
    mov dword[esp + 4], msg
    mov dword[esp + 8], x
    call fscanf
    
    cmp eax, -1
    je .EL
    
    inc dword[s]
    jmp .L
    
.EL:

    mov edx, dword[s]
    mov dword[esp + 4], edx
    mov dword[esp], msg
    call printf
    
    mov edx, dword[f]
    mov dword[esp], edx
    call fclose  
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret