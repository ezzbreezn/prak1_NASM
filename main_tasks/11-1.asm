%include "io.inc"

section .rodata
    msg db `%d`, 0
    msgo db `%d\n`, 0
    
section .bss
    a resd 1
    n resd 1
    temp resd 1
    
    
CEXTERN scanf
CEXTERN printf
CEXTERN malloc
CEXTERN free    

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
    
    mov dword[esp], msg
    mov dword[esp + 4], temp
    call scanf
    
    mov edx, dword[temp]
    mov ecx, dword[a]
    call ADDHEAD
    mov dword[a], eax
    
    mov ecx, dword[a]
    call DELLAST
    
    mov ecx, dword[a]
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
    and esp, ~15
    sub esp, 16
    mov edi, ecx
.L:    
    test edi, edi
    je .out
    mov dword[esp], msgo
    mov eax, dword[edi]
    mov dword[esp + 4], eax
    call printf
    
    mov edi, dword[edi + 4]
    jmp .L
    
.out:  
    mov esp, ebp
    sub esp, 4
    pop edi
    pop ebp
    ret
    
ADDHEAD:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    mov edi, ecx
    mov esi, edx
    
    mov dword[esp], 8
    call malloc
    
    mov dword[eax], esi
    mov dword[eax + 4], edi
    
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    ret
DELLAST:
    push ebp
    mov ebp, esp
    push edi
    push esi
    push ebx
    and esp, ~15
    sub esp, 16
    
    mov edi, ecx
    mov esi, ecx
    xor ebx, ebx
    
    test edi, edi
    je .out
    
.L:
    cmp dword[edi + 4], 0
    jne .ni
    mov ecx, dword[ebx + 4]
    mov dword[esp], ecx
    call free
    mov dword[ebx + 4], 0
    mov eax, esi
    jmp .out
    
.ni:
    mov ebx, edi
    mov edi, dword[edi + 4]
    jmp .L
    
.out:    
    mov esp, ebp
    sub esp, 12
    pop ebx
    pop esi
    pop edi
    pop ebp
    ret