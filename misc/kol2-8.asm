%include "io.inc"

section .rodata
    msg db `%hi`, 0
    msgs db `%d`, 0
CEXTERN scanf
CEXTERN printf

section .bss
    a resw 1
    b resw 1
    d resw 1
    c resd 1

section .text
global CMAIN
CMAIN:
    ;write your code here
    push ebp
    mov ebp, esp
    sub esp, 16
    mov dword[esp], msg
    mov dword[esp + 4], a
    call scanf
    
    mov dword[esp +4 ], b
    call scanf
    
    mov dword[c], d
    
    
    inc word[b]
    cmp word[b], 0
    je .n
    movsx eax, word[b]
    sal eax, 1
    mov ecx, dword[c]
    mov word[ecx], ax
    jmp .out
.n:
    dec word[a]
    movsx eax, word[a]    
.out:
    mov dword[esp], msg
    mov dword[esp +4 ], eax
    call printf    
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret