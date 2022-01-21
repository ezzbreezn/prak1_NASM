%include "io.inc"

section .rodata
    msg db `%u`, 0

section .bss
    array resd 1
    ans resd 1
    pos resd 1
    

section .data
    size dd 1000

CEXTERN scanf
CEXTERN printf
CEXTERN malloc
CEXTERN realloc
CEXTERN free

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    push ebx
    and esp, ~15
    sub esp, 16
    mov edx, dword[size]
    sal edx, 2
    mov dword[esp], edx
    call malloc
    mov dword[array], eax
    xor ebx, ebx

.L:
    cmp ebx, dword[size]
    jl .skip
    mov edx, dword[array]
    mov dword[esp], edx
    sal dword[size], 1
    mov edx, dword[size]
    sal edx, 2
    mov dword[esp + 4], edx
    call realloc
    mov dword[array], eax
.skip:
    mov edx, dword[array]
    lea edx, [edx + 4 * ebx]
    mov dword[esp + 4], edx
    mov dword[esp], msg
    call scanf
    mov edx, dword[array]
    lea edx, [edx + 4 * ebx]
    mov edx, dword[edx]
    test edx, edx
    je .EL
    inc ebx
    jmp .L
.EL:
    mov dword[pos], ebx
    dec dword[pos]
    mov edx, dword[array]
    lea edx, [edx + 4 * ebx - 4]
    mov edx, dword[edx]
    xor ecx, ecx
.L1:
    cmp ecx, dword[pos]
    je .EL1
    mov eax, dword[array]
    lea eax, [eax + 4 * ecx]
    mov eax, dword[eax]
    cmp eax, edx
    jge .next
    inc dword[ans]
.next:
    inc ecx
    jmp .L1
.EL1:
    mov edx, dword[ans]
    mov dword[esp + 4], edx
    mov dword[esp], msg
    call printf
    mov edx, dword[array]
    mov dword[esp], edx
    call free
    mov esp, ebp
    sub esp, 4
    pop ebx
    pop ebp
    xor eax, eax
    ret