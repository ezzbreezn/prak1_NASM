%include "io.inc"
section .bss
    k resd 1

section .text
global CMAIN
CMAIN:
    ;write your code here
    GET_DEC 4, [k]
    mov edi, 0
    mov esi, 0
.L: 
    cmp edi, dword[k]
    je .EL
    inc esi
    push esi
    call F
    add esp, 4
    cmp eax, 1
    jne .ni
    inc edi
.ni:
    jmp .L    
.EL:
    PRINT_DEC 4, esi
        
    xor eax, eax
    ret
    
    
F:  
    push ebp
    mov ebp, esp
    push ebx
    
    xor ebx, ebx
    mov ecx, 1
.L:
    cmp ecx, dword[ebp + 8]
    jge .EL
    mov eax, dword[ebp + 8]
    xor edx, edx
    div ecx
    test edx, edx
    jne .ni
    add ebx, ecx
.ni:
    inc ecx
    jmp .L    
    
.EL:  
    cmp ebx, dword[ebp + 8]
    jge .l
    mov eax, 1
    jmp .out
.l:
    mov eax, 0    
.out:    
    mov esp, ebp
    sub esp, 4
    pop ebx
    pop ebp    
    ret
    