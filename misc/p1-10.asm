%include "io.inc"

section .bss
    m resd 1
    d resd 1
    ans resd 1

section .text
global CMAIN
CMAIN:
    GET_DEC 4, [m]
    GET_DEC 4, [d]
    mov eax, dword[m]
    dec eax
    shr eax, 1
    mov ebx, 42
    mul ebx
    add dword[ans], eax
    mov eax, dword[m]
    dec eax
    shr eax, 1
    mov ecx, dword[m]
    dec ecx
    and ecx, 1
    add eax, ecx
    mov ebx, 41
    mul ebx
    add dword[ans], eax
    mov eax, dword[d]
    add dword[ans], eax
    PRINT_DEC 4, [ans]
    xor eax, eax
    ret