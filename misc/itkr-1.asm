%include "io.inc"

section .rodata
    msg db `%d`, 0
    
CEXTERN scanf
CEXTERN printf
CEXTERN malloc
CEXTERN free

section .bss
    a resd 1
    n resd 1    

section .text
global CMAIN
CMAIN:
    ;write your code here
    push ebp
    mov ebp, esp
    push edi
    push esi
    sub esp, 20
    
    mov dword[esp], msg
    mov dword[esp + 4], n
    call scanf
    
    mov ecx, dword[n]
    sal ecx, 4
    mov dword[esp], ecx
    call malloc
    mov dword[a], eax
    
    mov edi, eax
    xor esi, esi
    mov dword[esp], msg
.L:
    cmp esi, dword[n]
    je .EL
    lea ecx, [edi + 4 * esi]
    mov dword[esp + 4], ecx
    call scanf
    inc esi
    jmp .L
    
.EL:    

    xor ecx, ecx
    xor eax, eax
.L1:
    cmp ecx, dword[n]
    je .EL1
    mov edx, dword[edi + 4 * ecx]
    test edx, 0x3
    je .skip
    add eax, dword[edi + 4 * ecx]
.skip:
    inc ecx
    jmp .L1
.EL1:    

    mov dword[esp], msg
    mov dword[esp + 4], eax
    call printf
    
    mov ecx, dword[a]
    mov dword[esp], ecx
    call free


    mov esp, ebp
    pop ebp
    xor eax, eax
    ret