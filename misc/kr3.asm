%include "io.inc"

section .bss
    a resd 1
    b resd 1
    res resd 1
    tmp resd 1

section .text
global CMAIN
CMAIN:
    GET_DEC 4, [a]
    GET_DEC 4, [b]
    mov ebx, 1
    xor ecx, ecx
    mov eax, dword[a]
    mov edx, dword[b]
    cmp eax, edx
    jge .L
    xchg eax, edx
    mov dword[a], eax
    mov dword[b], edx
.L:
    mov dword[tmp], 0
    test ebx, ebx
    je .EL
    cmp ebx, dword[b]
    jg .EL
    mov eax, dword[b]
    and eax, ebx
    shr eax, cl
.L2:
    test eax, eax
    je .EL2
    cmp eax, dword[a]
    jg .EL2
    mov edi, dword[a]
    and edi, eax
    or dword[tmp], edi
    sal eax, 1
    jmp .L2
        
.EL2:  
    mov edx, dword[tmp]
    sal edx, cl
    xor dword[res], edx
    sal ebx, 1
    inc ecx
    jmp .L              
        
.EL:  
    ;mov edx, dword[tmp]
    ;xor dword[res], edx    
    PRINT_UDEC 4, [res]          
    xor eax, eax
    ret