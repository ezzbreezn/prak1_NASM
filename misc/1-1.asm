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
    
    mov edi, dword[esp]
    mov esi, dword[esp +4 ]
    cmp edi, esi
    jl .n
    mov dword[esp], esi
    mov dword[esp +4 ], edi
    
.n:
    xor ebx, ebx
    xor edi, edi
    
    mov eax, dword[esp + 4]
    xor edx, edx
    mul dword[esp + 4]
    mov dword[esp + 28], eax
    
    finit
.l1:
    cmp edi, dword[esp]
    jg .el1
    fild dword[esp+28]
    mov eax, edi
    xor edx, edx
    mul edi
    fild edi
    fsubp
    fsqrt
    
    
    
.el1:            
    mov esp, ebp
    sub esp, 12
    pop ebx
    pop esi
    pop edi
    pop ebp
    ret 4
        