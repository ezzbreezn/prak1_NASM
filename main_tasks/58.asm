%include "io.inc"

section .rodata
    msg db `%s`, 0
    msgc db `%c`, 0
    pa db `YES`, 0
    na db `NO` ,0
    
CEXTERN scanf
CEXTERN printf
CEXTERN qsort

section .bss
    s1 resb 102
    s2 resb 102
    c resb 1
    l resd 1

section .text
global CMAIN
CMAIN:
    ;write your code here
    push ebp
    mov ebp, esp
    push edi
    push esi
    push ebx
    and esp, ~15
    sub esp, 16
    
    xor edi, edi
.L:
    mov dword[esp], msgc
    mov dword[esp + 4], c
    call scanf
    
    cmp byte[c], '.'
    je .EL
    mov cl, byte[c]
    mov byte[s1 + edi], cl
    inc edi
    jmp .L
.EL:    
    mov dword[l], edi
 
    mov dword[esp], s1
    mov dword[esp + 4], edi
    mov dword[esp + 8], 1
    mov dword[esp + 12], F
    call qsort

    mov edi, 1
    xor eax, eax
.l:
    cmp edi, dword[l]
    je .el
    mov cl, byte[s1 + edi - 1]
    mov dl, byte[s1 + edi]
    cmp cl, dl

    jne .skip
    mov eax, 1
    jmp .el
.skip:
    inc edi
    jmp .l    
.el:
    cmp eax, 1
    jne .neg
    mov dword[esp], pa
    call printf
    jmp .end
.neg:
    mov dword[esp], na
    call printf    
.end:    
    mov esp, ebp
    sub esp, 12
    pop ebx
    pop esi
    pop edi
    pop ebp
    xor eax, eax
    ret
    
    
F:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov ecx, dword[ebp + 8]
    mov edx, dword[ebp + 12]
    
    mov cl, byte[ecx]
    mov dl, byte[edx]
    cmp cl, dl
    jl .l
    jg .g
    xor eax, eax
    jmp .out
.l:
    mov eax, -1
    jmp .out    
.g:    
    mov eax, 1 
.out:    
    mov esp, ebp
    pop ebp
    ret