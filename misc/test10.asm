%include "io64.inc"

section .data
    a db 43
    b dd 17
    c dw 143
    
section .text
global CMAIN
CMAIN:
    mov ax, word [c]
    mov dx, ax
    sar dx, 15
    mov cx, 100
    idiv cx
    mov bx, ax
    mov ax, dx
    sar dx, 15
    mov cx, 10
    idiv cx
    imul ax, cx
    imul dx, cx
    imul dx, cx
    add bx, ax
    add bx, dx
    mov word[c], bx
    PRINT_DEC 2, [c]
    NEWLINE
    
    ;movzx eax, byte [a]
    ;sub eax, 500000
    ;mov edx, eax
    ;sar edx, 31
    ;mov ebx, 10
    ;idiv ebx
    ;mov dword[b], edx
    ;PRINT_DEC 4, [b]
    ;NEWLINE
    xor rax, rax
    ret