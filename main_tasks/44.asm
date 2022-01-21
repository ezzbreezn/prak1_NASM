%include "io.inc"

section .bss
    n resd 1
    o resd 1
    z resd 1

section .text
global CMAIN
CMAIN:
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
    xor eax, eax
    mov ecx, 1
.l:
    test ecx, ecx
    je .el
    cmp ecx, dword[ebp + 8]
    jg .el
    test ecx, dword[ebp + 8]
    je .az
    inc dword[o]
    jmp .ni
.az:
    inc dword[z]
.ni:
    sal ecx, 1
    jmp .l

    
.el:   
    mov edx, dword[o]
    cmp edx, dword[z]
    jle .out
    mov eax, 1
.out:
    mov esp, ebp
    pop ebp
    ret