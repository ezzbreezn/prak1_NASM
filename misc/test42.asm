%include "io64.inc"

section .bss
    u resd 1
    w resd 1
    w1 resd 1
    w2 resd 1
    w3 resd 1
    
section .data
    ar dd 33, 34, 35
    ar1 dw 1, 2, 3, 4, 5, 6, 7, 8, 9 ,10
    d dd 1
    c dd 3

section .text
global CMAIN
CMAIN:
    mov dword[u], ar
    mov dword[w1], ar1
    mov dword[w2], ar1+2
    mov dword[w3], ar1+4
    mov dword[w], w1
    
    mov eax, dword[w]
    mov eax, dword[eax+4]
    PRINT_DEC 2, [eax]
    NEWLINE
    NEWLINE
    
    mov eax, dword[d]
    mov edx, dword[c]
    mov eax, dword[w+eax*4]
    
    ;mov ebx, eax
    ;mov ebx, dword[ebx]
    ;PRINT_DEC 2, [ebx]
    ;NEWLINE
    movzx edx, word[eax+edx*2]
    mov eax, dword[u]
    mov dword[eax], edx
    
    
    mov ecx, 10
    mov eax, ar1
PRINT:
    PRINT_DEC 2, [eax]
    NEWLINE
    add eax, 2
    dec ecx
    jne PRINT
    
    mov ecx, 3
    mov eax, ar
PRINT1:
    PRINT_DEC 4, [eax]
    NEWLINE
    add eax, 4
    dec ecx
    jne PRINT1
    ;GET_DEC 4, [a]
    ;GET_DEC 4, [b]
    ;mov dword[p], a
    
    ;mov eax, dword[p]
    ;test eax, eax
    ;je NR
    ;movsx edx, word[eax]
    ;PRINT_DEC 4, edx
    ;NEWLINE
    ;add dword[p], 2
    ;add dword[b], edx
    ;mov eax, dword[b]
    ;test eax, eax
    ;je NR
    ;mov eax, 1
;NR:
    ;PRINT_DEC 4, eax
    ;NEWLINE
sas:
    xor rax, rax
    ret