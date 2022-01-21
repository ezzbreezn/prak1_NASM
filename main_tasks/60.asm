%include "io.inc"

section .rodata
    msg db `%d`, 0
    msgo db `%d `, 0
    
CEXTERN scanf
CEXTERN printf
CEXTERN malloc
CEXTERN free

section .bss
    root resd 1
    n resd 1
    x resd 1
    prev resd 1
    f resd 1

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    xor edi, edi
.L: 

    mov dword[esp], msg
    mov dword[esp + 4], x
    call scanf

    cmp dword[x], 0
    je .EL
    
    mov dword[esp], 8
    call malloc
    cmp edi, 0
    jne .skip
    mov dword[root], eax
.skip:    
    mov edx, dword[x]
    mov dword[eax] ,edx

    cmp dword[prev], 0
    je .ni
    mov edx, dword[prev]
    mov dword[edx + 4], eax
    
.ni:    
    mov dword[prev], eax
    inc edi
    jmp .L
.EL:    
    mov dword[n], edi
    
.s:
    mov dword[f], 0
    mov edi, dword[root]
    cmp edi, 0
    je .es
    cmp dword[edi + 4], 0
    je .es
    mov dword[prev], edi
    mov edi, dword[edi + 4]
.c:
    cmp edi, 0
    je .ec  
    mov ecx, dword[prev]
    mov ecx, dword[ecx]
    mov edx, dword[edi]
    cmp ecx, edx
    jle .ns
    mov dword[edi], ecx
    mov ecx, dword[prev]
    mov dword[ecx], edx
    mov dword[f], 1
    
.ns:    
    mov dword[prev], edi
    mov edi, dword[edi + 4]
    jmp .c
.ec:    
    cmp dword[f], 1
    jne .es
    jmp .s
    
.es:
    
    mov edx, dword[root]
    mov dword[esp], edx
    call PRINT

    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    xor eax, eax
    ret
    
    
PRINT:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    mov edi, dword[ebp + 8]
    test edi, edi
    je .out
    
    mov edx, dword[edi]
    mov dword[esp + 4], edx
    mov dword[esp], msgo
    call printf
    
    mov edi, dword[edi + 4]
    mov dword[esp], edi
    call PRINT
    
    
.out:
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    ret