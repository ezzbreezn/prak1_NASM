%include "io.inc"

section .bss
    n resd 1
    

section .text
global CMAIN
CMAIN:
    ;write your code here
    GET_UDEC 4, [n]
    push dword[n]
    call F
    add esp, 4
    PRINT_DEC 4, eax
    
    xor eax, eax
    ret
    
    
F:
    push ebp
    mov ebp, esp
    push ebx
    xor eax, eax
    mov ecx, 1
.l:
    test ecx, ecx
    je .el
    cmp ecx, dword[ebp + 8]
    jg .el
    test ecx, dword[ebp + 8]
    je .neg
    inc ebx
    cmp ebx, 5
    jne .skip
    mov eax, 1
    jmp .out
.neg:
    mov ebx, 0
.skip:
    sal ecx, 1
    jmp .l
.el: 
    cmp ebx, 5
    jne .out
    mov eax, 1
.out:   
    mov esp, ebp
    sub esp, 4
    pop ebx
    pop ebp
    ret