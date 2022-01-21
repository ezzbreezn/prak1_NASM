%include "io.inc"

section .rodata
    msg db `%d`, 0
    p db `YES\n`, 0
    no db `NO\n`, 0
    
CEXTERN scanf
CEXTERN printf

section .bss
    n resd 1

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    push edi
    sub esp, 8
    
    mov dword[esp], msg
    mov dword[esp + 4], n
    call scanf
    
    xor ecx, ecx
    mov eax, dword[n]
.L:
    cmp eax, 1
    je .EL
    test eax, eax
    je .EL
    test eax, 0x7
    jne .EL
    inc ecx
    shr eax, 3
    jmp .L
    
.EL:    
    mov edi, ecx
    cmp eax, 1
    je .p
    mov dword[esp], no
    call printf

    jmp .out
.p: 
    mov dword[esp], p
    call printf
        mov dword[esp], msg
    mov dword[esp + 4], edi
    call printf
.out:        
    mov esp, ebp
    sub esp, 4
    pop edi
    pop ebp
    xor eax, eax
    ret