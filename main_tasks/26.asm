%include "io.inc"

section .rodata
    msg db `%d`, 0
    msgo db `%d `, 0
    
    
CEXTERN scanf
CEXTERN printf
CEXTERN malloc
CEXTERN free
CEXTERN qsort

section .bss
    a resd 1
    n resd 1

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
    
    mov edx, dword[n]
    sal edx, 2
    mov dword[esp], edx
    call malloc
    
    mov dword[a], eax
    
    
    xor edi, edi
    mov esi, dword[a]
.L:
    cmp edi, dword[n]
    je .EL
    mov dword[esp], msg
    lea edx, [esi + 4 * edi]
    mov dword[esp + 4], edx
    call scanf
    inc edi
    jmp .L
.EL:    
    mov edx, dword[a]
    mov dword[esp], edx
    mov edx, dword[n]
    mov dword[esp + 4], edx
    mov dword[esp + 8], 4
    mov dword[esp + 12], COMP
    call qsort
    xor edi, edi
    mov esi, dword[a]
.L1:
    cmp edi, dword[n]
    je .EL1
    
    mov dword[esp], msgo
    mov edx, dword[esi + 4 * edi]
    mov dword[esp + 4], edx
    call printf
    inc edi
    jmp .L1

.EL1:
    mov edx, dword[a]
    mov dword[esp], edx
    call free
    
    
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    
    xor eax, eax
    ret
    
COMP:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov ecx, dword[ebp + 8]
    mov edx, dword[ebp + 12]
    mov ecx, dword[ecx]
    mov edx, dword[edx]
    
    cmp ecx, edx
    jl .L
    jg .G
    xor eax, eax
    jmp .out
.L:
    mov eax, -1
    jmp .out
.G:
    mov eax, 1
.out:
    
    mov esp, ebp
    pop ebp
    ret