%include "io.inc"

section .bss
    a11 resd 1
    a12 resd 1
    a21 resd 1
    a22 resd 1
    b1 resd 1
    b2 resd 1
    x resd 1
    y resd 1

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, [a11]
    GET_UDEC 4, [a12]
    GET_UDEC 4, [a21]
    GET_UDEC 4, [a22]
    GET_UDEC 4, [b1]
    GET_UDEC 4, [b2]
    mov eax, dword[a11]
    and eax, dword[a22]
    mov ecx, dword[a12]
    and ecx, dword[a21]
    xor eax, ecx
    mov dword[x], eax
    mov eax, dword[b1]
    and eax, dword[a22]
    mov ecx, dword[b2]
    and ecx, dword[a12]
    xor eax, ecx
    and dword[x], eax
    
    ;PRINT_UDEC 4, [x]
    ;PRINT_CHAR ' '
    
    ;and eax, dword[a21]
    ;xor eax, dword[b2]
    ;and eax, dword[a22]
    ;PRINT_UDEC 4, eax
    
    mov eax, dword[a12]
    and eax, dword[a21]
    mov ecx, dword[a11]
    and ecx, dword[a22]
    xor eax, ecx
    mov dword[y], eax
    mov eax, dword[b2]
    and eax, dword[a11]
    mov ecx, dword[b1]
    and ecx, dword[a21]
    xor eax, ecx
    and dword[y], eax
    PRINT_UDEC 4, [x]
    PRINT_CHAR ' '
    PRINT_UDEC 4, [y]
    xor eax, eax
    ret