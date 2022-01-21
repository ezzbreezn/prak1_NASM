%include "io64.inc"

section .data
    a dd 22
    b dd 7
    
section .bss
    x resd 1
    arr resd 6

section .text
global CMAIN
CMAIN:
    mov rbp, rsp; for correct debugging
    ;cmp dword [a], 0
    ;je L1
    ;mov eax, dword [b]
    ;cdq
    ;idiv dword [a]
    ;jmp L2
;L1:
    ;mov eax, 0
;L2:
    ;mov dword [x], eax
    ;PRINT_DEC 4, [x]
    ;NEWLINE
    
    
    ;mov eax, dword [a]
    ;cmp eax, 0
    ;js L1
    ;jmp L2
;L1:
    ;imul eax, -1
;L2:
    ;PRINT_DEC 4, eax
    ;NEWLINE
    
    ;mov eax, dword [a]
    ;mov edx, eax
    ;neg edx
    ;cmp eax, edx
    ;cmovl eax, edx
    ;PRINT_DEC 4, eax
    ;NEWLINE
    
    mov ecx, 5
    mov ebx, arr
    cmp ecx, 0
    je L2
L1:
    GET_DEC 4, [ebx]
    add ebx, 4
    dec ecx
    cmp ecx, 0
    jne L1
L2:
    PRINT_DEC 4, [arr]
    NEWLINE
    PRINT_DEC 4, [arr + 4]
    NEWLINE
    PRINT_DEC 4, [arr + 8]
    NEWLINE
    PRINT_DEC 4, [arr + 12]
    NEWLINE
    PRINT_DEC 4, [arr + 16]
    NEWLINE
    
    mov ecx, 5
    mov ebx, arr
    cmp ecx, 0
    je L4
    mov edx, dword [ebx]
L3:
    cmp dword [ebx], edx
    cmovg edx, dword [ebx]
    add ebx, 4
    dec ecx
    cmp ecx, 0
    jne L3
L4:
    PRINT_DEC 4, edx
    NEWLINE
    xor rax, rax
    ret