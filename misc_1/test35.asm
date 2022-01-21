%include "io64.inc"

section .data
    a dw -4
    b dw 256

section .text
global CMAIN
CMAIN:
    ;mov al, 3
    ;rol al, 3
    ;PRINT_DEC 1, al
    ;NEWLINE
    
    ;movsx eax, word [a]
    ;shl eax, 16
    ;movzx ebx, word [b]
    ;ror bx, 5
    ;add eax, ebx
    ;PRINT_DEC 4, eax
    ;NEWLINE
    
    ;movsx eax, word [a]
    ;mov edx, eax
    ;shl eax, 2
    ;shl edx, 1
    ;add eax, edx
    ;PRINT_DEC 4, eax
    ;NEWLINE
    
    mov eax, -3
    mov edx, eax
    sar edx, 31
    xor eax, edx
    sub eax, edx
    PRINT_DEC 4, eax
    NEWLINE
    mov eax, 1
    not eax
    PRINT_DEC 4, eax
    NEWLINE
    mov eax, 10
    btc eax, 3
    PRINT_DEC 4, eax
    NEWLINE
    xor rax, rax
    ret