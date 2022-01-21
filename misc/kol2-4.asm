%include "io.inc"

section .rodata
    msg db `%d`, 0
    
CEXTERN scanf
CEXTERN printf

section .bss
    a resd 1000
    

section .text
global CMAIN
CMAIN:
    ;write your code here
    push ebp
    mov ebp, esp
    push edi
    
    xor edi, edi
    
.L1:
    cmp edi, 10
    je .EL1 
    lea ecx, [a + 4 * edi]
    mov dword[esp + 4], ecx
    mov dword[esp], msg
    call scanf
    inc edi
    jmp .L1
    
.EL1:    

    xor eax, eax
    xor ecx, ecx
.L:
    cmp ecx, 10
    je .EL
    mov edx, dword[a + 4 * ecx]
    test edx, 0x3
    je .skip
    add eax, dword[a + 4 * ecx]
.skip:    
    inc ecx
    jmp .L     
.EL:    

    mov dword[esp], msg
    mov dword[esp +4], eax
    call printf

    mov esp, ebp
    pop ebp
    xor eax, eax
    ret