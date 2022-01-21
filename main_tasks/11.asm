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
    
    push dword[temp]
    push dword[a]
    call ADDHEAD
    mov dword[a], eax
    add esp, 8
    
    push dword[a]
    call DELLAST
    add esp, 4
    
    
    push dword[a]
    call PRINT
    add esp, 4
    
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
    
    mov edi, dword[ebp + 8]
.L:
    test edi, edi
    je .EL
    
    mov dword[esp], msgo
    mov ecx, dword[edi]
    mov dword[esp + 4], ecx
    call printf
    
    mov edi, dword[edi + 4]
    jmp .L
        
.EL:    
    mov esp, ebp
    sub esp, 4
    pop edi
    pop ebp
    ret
    
ADDHEAD:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], 8
    call malloc
    
    mov ecx, dword[ebp + 12]
    mov dword[eax], ecx
    
    mov ecx, dword[ebp + 8]
    mov dword[eax + 4], ecx
    
    mov esp, ebp
    pop ebp
    ret
    
DELLAST:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    xor esi, esi
    mov edi, dword[ebp + 8]
    test edi, edi
    je .out
.L:
    cmp dword[edi + 4], 0
    je .proc
    mov esi, edi
    mov edi, dword[edi + 4]
    jmp .L
.proc:
    mov edx, dword[esi + 4]
    mov dword[esp], edx
    call free
    mov dword[esi + 4], 0
    mov eax, dword[ebp + 8]
    
.out:
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    ret