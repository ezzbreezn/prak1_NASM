%include "io64.inc"

section .bss
    a resd 1
    b resd 1
    c resd 1
    strr resb 100
    
section .data
    a_value dd 8

section .text
global CMAIN
CMAIN:
    ;GET_DEC 4, [b]
    ;GET_DEC 4, [c]
    ;mov dword[a], a_value
    
    ;mov eax, dword[a]
    ;test eax, eax
    ;je .P1
    ;mov ebx, dword[b]
    ;mov ecx, dword[c]
    ;cmp ebx, ecx
    ;jnge .P2
    ;add dword[eax], ebx
    ;jmp .P2
;.P1:
    ;mov dword[a], c
    ;mov eax, dword[a]
    ;sub dword[eax], ebx
;.P2:
    ;mov eax, dword[a]
    ;mov eax, dword[eax]
    ;PRINT_DEC 4, eax
    ;NEWLINE
    ;PRINT_DEC 4, [b]
    ;NEWLINE
    ;PRINT_DEC 4, [c]
    ;NEWLINE
    GET_DEC 4, [a]
    mov ecx, dword[a]
    mov eax, 0
.point:
    GET_CHAR [strr+eax]
    inc eax
    loop .point
    
    PRINT_CHAR [strr]
    NEWLINE
    PRINT_CHAR [strr+1]
    NEWLINE
    PRINT_STRING [strr]
    NEWLINE
    xor rax, rax
    ret