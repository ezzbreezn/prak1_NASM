%include "io.inc"

section .bss
    x resd 1

section .text
global CMAIN
CMAIN:
    ;write your code here
    push 1
    call F
   add esp,4 
    xor eax, eax
    ret
    
F:
    push ebp
    mov ebp, esp
    push edi
    sub esp, 4
    GET_DEC 4, edi
    cmp edi, 0
    je .out
    mov edx, dword[ebp + 8]
    test edx, 1
    je .c
    PRINT_DEC 4, edi
    PRINT_CHAR ' '
    mov edx, dword[ebp + 8]
    inc edx
    push edx
    call F
    add esp, 4
    jmp .out 
.c:
    mov edx, dword[ebp + 8]
    inc edx
    push edx
    call F
    add esp, 4
    PRINT_DEC 4, edi
    PRINT_CHAR ' '      
.out: 
    mov esp, ebp
    sub esp, 4
    pop edi
    pop ebp
    ret
    
