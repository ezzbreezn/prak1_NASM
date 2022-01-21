%include "io.inc"

section .bss
    a resd 1
    b resd 1
    c resd 1

section .text
global CMAIN
CMAIN:
    ;write your code here
    GET_DEC 4, [a]
    GET_DEC 4, [b]
    GET_DEC 4, [c]
    mov ecx, dword[a]
    mov edx, dword[b]
    push dword[c]
    call suns
    PRINT_DEC 4, eax
    xor eax, eax
    ret
    
global suns
suns:
    push ebp
    mov ebp, esp
    push edi
    push esi
    push ebx
    sub esp, 32
    ;cmp ecx, edx
    ;jle .n
    ;xchg ecx, edx
    
    xor ebx, ebx
    cmp ecx, 0
    jle .st
    cmp edx, 0
    jle .st
    cmp dword[ebp + 8], 0
    jle .st
    jmp .norm
.st:
    xor eax, eax    
    jmp .out
    
.norm:    
    mov dword[esp + 12], edx
    cmp ecx, dword[ebp + 8]
    jl .m1
    mov edi, dword[ebp + 8]
    mov dword[esp + 4], edi
    jmp .next
.m1:    
    mov dword[esp + 4], ecx
.next:  
    cmp edx, dword[ebp + 8]
    jl .m2
    mov edi, dword[ebp + 8]    
    mov dword[esp], edi
    jmp .next2
.m2:
    mov dword[esp], edx    
.next2:    
    
    mov eax, dword[ebp + 8]
    xor edx, edx
    mul dword[ebp + 8]
    mov dword[esp + 16], eax
    
.n:
    xor ebx, ebx
    mov edi, 1
.l1:
    cmp edi, dword[esp]
    je .el1
    mov esi, 1
.l2:
    cmp esi, dword[esp + 4]
    je .el2
    mov eax, edi
    xor edx, edx
    mul edi
    mov dword[esp + 8], eax
    mov eax, esi
    xor edx, edx
    mul esi
    add dword[esp + 8], eax

    mov eax, dword[esp + 16]
    cmp dword[esp + 8], eax
    jge .skip
    inc ebx
.skip:
    inc esi
    jmp .l2  
.el2:    
    inc edi
    jmp .l1      
.el1:  
    sal ebx, 2
    inc ebx
    mov edi, ecx
    cmp edi, dword[ebp + 8]
    cmovg edi, dword[ebp + 8]  
    mov esi, dword[esp + 12]
    cmp esi, dword[ebp + 8]
    cmovg esi, dword[ebp + 8]
    dec edi
    dec esi
    add esi, edi
    sal esi, 1
    add ebx, esi
    mov eax, ebx
    
.out:    
    mov esp, ebp
    sub esp, 12
    pop ebx
    pop esi
    pop edi
    pop ebp
    ret 4
        