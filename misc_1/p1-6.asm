%include "io.inc"

section .bss
    n resd 1
    k resd 1

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, [n]
    GET_UDEC 4, [k]
    mov ecx, 32
    sub ecx, dword[k]
    mov eax, dword[n]
    shl eax, cl
    shr eax, cl
    PRINT_UDEC 4, eax
    
    xor eax, eax
    ret