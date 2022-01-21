%include "io.inc"

section .rodata
    msg db `%d`, 0
    
section .bss
    a resd 1
    n resd 1    
    
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
    
    mov dword[esp], 8
    call malloc
    mov dword[a], eax
    
    xor edi, edi
    mov esi, dword[a]
    
.L:
    cmp edi, dword[n]
    je .EL
    mov dword[esp], msg
    mov dword[esp + 4], esi
    call scanf
    
    inc edi
    cmp edi, dword[n]
    je .EL
    
    mov dword[esp], 8
    call malloc
    mov dword[esi + 4], eax
    mov esi, dword[esi + 4]
    jmp .L
.EL:     
    push dword[a]
    call F
    add esp, 4
    
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
    sub esp, 16
    xor eax, eax
    cmp dword[esp + 20], 0
    je .out  
    mov edx, dword[esp + 20]
    mov edx, dword[edx + 4]
    mov dword[esp], edx
    call F
    mov edx, dword[esp + 20]
    mov edx, dword[edx]
    add eax, edx
      
.out:
    add esp, 16
    ret          