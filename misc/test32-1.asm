%include "io.inc"

section .data
    a dq 2, 50, 23, 76, -8, 100, 4, 0, 12, 1000

section .text
global CMAIN
CMAIN:
    xor ecx, ecx
    cmp ecx, 10
    jge .E
.L:
    sub dword[a + 8 * ecx], ecx
    sbb dword[a + 8 * ecx - 7], 0
    inc ecx
    cmp ecx, 10
    jl .L
    
.E:
    
    xor ecx, ecx
.PRINT: 
    PRINT_DEC 4, [a + 8 * ecx]
    NEWLINE
    inc ecx
    cmp ecx, 10
    jl .PRINT
    lea eax, [-3 + 9 + ecx * 8 + ecx]
    mov eax, 4
    imul eax, -10
    PRINT_DEC 4, [eax]
    NEWLINE
    xor eax, eax
    ret