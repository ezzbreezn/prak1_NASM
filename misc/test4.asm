%include "io64.inc"

section .data
    a dw 0x0DEC
    b dw 0x4A6F
    c dw 0x7921
    d dw 0xFEFF

section .text
global CMAIN
CMAIN:
    mov ebx, dword [b]
    mov eax, -1
    movzx ax, bl
    PRINT_HEX 4, eax
    NEWLINE
    mov ecx, dword [a + 1]
    mov eax, dword [b + 1]
    movsx ax, cl
    PRINT_HEX 4, eax
    NEWLINE
    mov eax, dword [c]
    bswap eax
    PRINT_HEX 4, eax
    NEWLINE
    xor rax, rax
    ret