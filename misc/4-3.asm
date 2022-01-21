%include "io.inc"

section .rodata
    msg db `%s`, 0
    lb db `[`, 0
    rb db ']', 0
    msgc db `%c`, 0
    
CEXTERN fgets
CEXTERN strstr
CEXTERN strlen
CEXTERN printf
CEXTERN scanf

section .bss
    s1 resb 102
    s2 resd 102
    l1 resd 1
    l2 resd 1
    tmp resd 1

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msg
    mov dword[esp + 4], s1
    call scanf
    
    mov dword[esp], msg
    mov dword[esp + 4], s2
    call scanf
    
    mov dword[esp], s1
    call strlen
    mov dword[l1], eax
    
    mov dword[esp], s2
    call strlen
    mov dword[l2], eax
    
    mov dword[esp], s1
    mov dword[esp + 4], s2
    call strstr
    test eax, eax
    je .n1
    mov edi, eax
    ;mov esi, s1
    xor esi, esi
.l1:
    lea ecx, [s1 + esi]
    cmp ecx, edi
    je .el1
    mov dword[esp], msgc
    movsx edx, byte[s1 + esi]
    mov dword[esp + 4], edx
    call printf
    inc esi
    jmp .l1
.el1:    
    mov dword[esp], lb
    call printf
    
    xor edi, edi
.ll1:
    cmp edi, dword[l2]
    je .ell1
    mov dword[esp], msgc
    movsx edx, byte[s1 + esi]
    mov dword[esp + 4], edx
    call printf
    inc esi
    inc edi
    jmp .ll1
    
.ell1:  
    mov dword[esp], rb
    call printf
    cmp byte[s1 + esi], 0
    je .end  
.lll1:
    cmp byte[s1 + esi], 0
    je .elll1
    mov dword[esp], msgc
    movsx edx, byte[s1 + esi]
    mov dword[esp + 4], edx
    call printf
    inc esi
    jmp .lll1
.elll1:
    jmp .end
.n1:    
    mov dword[esp], s2
    mov dword[esp + 4], s1
    call strstr
    test  eax, eax
    je .def
    
    mov edi, eax
    ;mov esi, s1
    xor esi, esi
.l2:
    lea ecx, [s2 + esi]
    cmp ecx, edi
    je .el2
    mov dword[esp], msgc
    movsx edx, byte[s2 + esi]
    mov dword[esp + 4], edx
    call printf
    inc esi
    jmp .l2
.el2:    
    mov dword[esp], lb
    call printf
    
    xor edi, edi
.ll2:
    cmp edi, dword[l1]
    je .ell2
    mov dword[esp], msgc
    movsx edx, byte[s2 + esi]
    mov dword[esp + 4], edx
    call printf
    inc esi
    inc edi
    jmp .ll2
    
.ell2:  
    mov dword[esp], rb
    call printf
    cmp byte[s2 + esi], 0
    je .end  
.lll2:
    cmp byte[s2 + esi], 0
    je .elll2
    mov dword[esp], msgc
    movsx edx, byte[s2 + esi]
    mov dword[esp + 4], edx
    call printf
    inc esi
    jmp .lll2
.elll2:
    jmp .end
.def:
    mov dword[esp], msg
    mov dword[esp + 4], s1
    call printf
    
    
.end:    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret