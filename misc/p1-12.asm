%include "io.inc"

section .bss
    n resd 1

section .data
    suit db 'S', 'C', 'D', 'H'
    value db '2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A'

section .text
global CMAIN
CMAIN:
    GET_DEC 4, [n]
    dec dword[n]
    mov eax, dword[n]
    xor edx, edx
    mov ecx, 13
    div ecx
    PRINT_CHAR [value + edx]
    PRINT_CHAR [suit + eax]
    xor eax, eax
    ret