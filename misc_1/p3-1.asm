%include "io.inc"

section .bss
    a resd 1
    b resd 1
    c resd 1
    d resd 1
    res resd 1

section .text
global CMAIN
CMAIN:
    GET_DEC 4, [a]
    GET_DEC 4, [b]
    GET_DEC 4, [c]
    GET_DEC 4, [d]
    
    push dword[b]
    push dword[a]
    call GCD
    add esp, 8
    push eax
    push dword[c]
    call GCD
    add esp, 8
    push eax
    push dword[d]
    call GCD
    add esp, 8
    PRINT_DEC 4, eax
    xor eax, eax
    ret
    
GCD:
    push ebp
    mov ebp, esp
    push ebx
    mov ebx, dword[ebp + 8]
    mov ecx, dword[ebp + 12]
    cmp ebx, ecx
    jge .skip
    xchg ebx, ecx
.skip:
.L:
    test ecx, ecx
    je .EL
    mov eax, ebx
    xor edx, edx
    div ecx
    mov ebx, ecx
    mov ecx, edx
    jmp .L
.EL:
    mov eax, ebx
            
    mov esp, ebp
    sub esp, 4
    pop ebx
    pop ebp
    ret    