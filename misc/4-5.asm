%include "io.inc"


section .rodata
    msg db `%d`, 0
    
CEXTERN scanf
CEXTERN printf
CEXTERN malloc
CEXTERN free 
CEXTERN realloc

section .data
    s dd 10000

section .bss
    x resd 1
    a resd 1
    n resd 1
    prev resd 1

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov edx, dword[s]
    sal edx, 2
    mov dword[esp], edx
    call malloc
    
    mov dword[a], eax
    mov esi, dword[a]
    xor edi, edi
.L:
    mov dword[esp], msg
    mov dword[esp + 4], x
    call scanf
    
    cmp dword[x], 0
    je .EL
    
    inc dword[n]
    mov edx, dword[n]
    cmp edx, dword[s]
    jle .next
    mov edx, dword[s]
    sal edx, 1
    mov dword[s], edx
    sal edx, 2
    mov dword[esp + 4], edx
    mov ecx, dword[a]
    mov dword[esp], ecx
    call realloc
    mov dword[a], eax
    mov esi, eax
.next:
    mov edx, dword[x]
    mov dword[prev], edx
    mov dword[esi + 4 * edi], edx
    
    
    inc edi
    jmp .L
    
.EL:    
    mov dword[x], 0
    
    mov esi, dword[a]
    xor edi, edi
.L1:
    cmp edi, dword[n]
    je .EL1
    
    mov edx, dword[esi + 4 * edi]
    cmp edx, dword[prev]
    jge .skip
    inc dword[x]
 .skip:   
    inc edi
    jmp .L1
.EL1:    
    mov dword[esp], msg
    mov edx, dword[x]
    mov dword[esp + 4], edx
    call printf
    
    mov edx, dword[a]
    mov dword[esp], edx
    call free

    mov esp, ebp
    pop ebp
    xor eax, eax
    ret