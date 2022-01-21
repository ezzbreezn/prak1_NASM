%include "io.inc"

section .rodata
    msg db `%lf`, 0
    msgo db `%lf `, 0
    
CEXTERN scanf
CEXTERN printf
CEXTERN malloc
CEXTERN free

section .bss
    root resd 1
    n resd 1
    x resd 2
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
    
    mov dword[esp], 16
    call malloc
    cmp edi, 0
    jne .skip
    mov dword[root], eax
.skip:    
    mov edx, dword[x]
    mov dword[eax] ,edx
    mov edx, dword[x + 4]
    mov dword[eax + 4], edx

    cmp dword[prev], 0
    je .ni
    mov edx, dword[prev]
    mov dword[edx + 8], eax
    
.ni:    
    mov dword[prev], eax
    inc edi
    jmp .L
.EL:    
    mov dword[n], edi
    
    finit
.s:
    mov dword[f], 0
    mov edi, dword[root]
    cmp edi, 0
    je .es
    cmp dword[edi + 8], 0
    je .es
    mov dword[prev], edi
    mov edi, dword[edi + 8]
.c:
    cmp edi, 0
    je .ec  
    mov edx, dword[prev]
    fld qword[edx]
    fld qword[edi]
    fucomip
    jae .ns
    mov esi, dword[edi]
    mov ecx, dword[edx]
    mov dword[edx], esi
    mov dword[edi], ecx
    mov esi, dword[edi + 4]
    mov ecx, dword[edx + 4]
    mov dword[edx + 4], esi
    mov dword[edi + 4], ecx
    mov dword[f], 1
    
.ns:    
    mov dword[prev], edi
    mov edi, dword[edi + 8]
    finit
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
    mov edx, dword[edi + 4]
    mov dword[esp + 8], edx
    mov dword[esp], msgo
    call printf
    
    mov edi, dword[edi + 8]
    mov dword[esp], edi
    call PRINT
    
    
.out:
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    ret