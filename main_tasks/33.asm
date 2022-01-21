%include "io.inc"

section .rodata
    msg db `%d`, 0
    msgo db `%d `, 0
    
CEXTERN scanf
CEXTERN printf
CEXTERN malloc
CEXTERN free

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
    inc edx
    sal edx, 2
    sub esp, edx
    sub esp, 16
    xor edi, edi
.L:
    cmp edi, dword[n]
    je .EL
    mov dword[esp], msg
    lea edx, [esp + 4 * edi + 20]
    mov dword[esp + 4], edx
    call scanf
    inc edi
    jmp .L
    
.EL:    
    add esp, 16
    mov edx, dword[n]
    mov dword[esp], edx
    call DYNAMO

    mov dword[a], eax
    
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
    cmp dword[a], 0
    je .out
    mov edx, dword[a]
    mov dword[esp], edx
    call free
    
.out:    
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    xor eax, eax
    ret
    
    
DYNAMO:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    xor eax, eax
    
    cmp dword[ebp + 8], 0
    je .out
    mov edx, dword[ebp + 8]
    sal edx, 2
    mov dword[esp], edx
    call malloc
    mov esi, eax
    xor edi, edi
.L:
    cmp edi, dword[ebp + 8]
    je .EL
    mov edx, dword[ebp + 4 * edi + 12]
    mov dword[esi + 4 * edi], edx
    inc edi
    jmp .L
    
.EL:    
    mov eax, esi
.out:    
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    ret
    