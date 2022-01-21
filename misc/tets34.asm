%include "io64.inc"

section .data
    a dd 2
    b dd 3
    c dd 1
    d dd 0

section .text
global CMAIN
CMAIN:
    ;mov al, -1
    ;inc al
    ;neg al
    ;PRINT_DEC 1, al
    ;NEWLINE
    mov eax, dword [a]
    and eax, dword [b]
    inc eax
    neg eax
    
    mov edx, dword [c]
    inc edx
    neg edx
    and edx, dword [d]
    mov ebx, dword [d]
    inc ebx
    neg ebx
    and ebx, dword [c]
    or edx, ebx
    or eax, edx
    mov dword [a], eax
    PRINT_DEC 4, [a]
    NEWLINE
    ;mov edx, dword [c]
    ;inc edx
    ;neg edx
    ;and edx, dword [d]
    ;or eax, edx
    ;mov edx, dword [d]
    ;inc edx
    ;neg edx
    ;and edx, dword[c]
    ;or eax, edx
    ;mov dword [a], eax
    ;PRINT_DEC 4, [a]
    ;NEWLINE
    xor rax, rax
    ret