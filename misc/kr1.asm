%include "io.inc"

section .rodata
    msg db `%u`, 0
  
section .bss
    a resd 2000
    n resd 1    
        
CEXTERN scanf
CEXTERN printf    
CEXTERN qsort


section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    xor edi, edi
.L:
    mov dword[esp], msg
    lea edx, [a + 4 * edi]
    mov dword[esp + 4], edx
    call scanf
    mov edx, dword[a + 4 * edi]
    test edx, edx
    je .EL
    inc edi
    jmp .L    
                
.EL:  
    mov dword[n], edi  
    mov dword[esp], a
    mov edx, dword[n]
    mov dword[esp + 4], edx
    mov dword[esp + 8], 4
    mov dword[esp + 12], F
    call qsort
    
    mov eax, dword[n]
    mov ebx, 3
    ;mul ebx
    sar eax, 2
    mul ebx

    
    mov edx, dword[a + 4 * eax - 4]
    
    mov dword[esp], msg
    mov dword[esp + 4], edx
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
    
    mov eax, dword[ebp + 8]
    mov edx, dword[ebp + 12]
    mov eax, dword[eax]
    mov edx, dword[edx]
    cmp eax, edx
    jb .l
    ja .g
    xor eax, eax
    jmp .out
.l:
    mov eax, -1
    jmp .out
.g:
    mov eax, 1
    jmp .out            
.out:            
    mov esp, ebp
    pop ebp
    ret     