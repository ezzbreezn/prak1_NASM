%include "io.inc"

section .bss
    x resd 1

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    
    GET_UDEC 4, [x]
    push dword[x]
    call F
    add esp, 4
    PRINT_DEC 4, eax
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
    
F:
    push ebp
    mov ebp, esp
    push ebx
    xor ecx, ecx
    mov ebx, 3
    mov eax, dword[ebp + 8]
.L:
    test eax, eax
    je .EL
    xor edx, edx
    div ebx
    cmp edx, 1
    jne .skip
    inc ecx
.skip:
    jmp .L
.EL:    
    mov eax, ecx    
    mov esp, ebp
    sub esp, 4
    pop ebx
    pop ebp
    ret            