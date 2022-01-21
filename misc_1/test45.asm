%include "io64.inc"

section .data
    a dd 10
    b dd 46

section .bss
    p resd 1
    x resd 1
    
section .text
global CMAIN
CMAIN:
    ;write your code here
    ;mov dword[p], b
    ;mov eax, dword[p]
    ;mov eax, dword[eax]
    ;PRINT_DEC 4, eax
    ;NEWLINE
    
    ;mov eax, dword[a]
    ;mov edx, dword[p]
    ;test edx, edx
    ;je .L
    ;test eax, eax
    ;je .L
    ;add dword[edx], eax
;.L:
    ;PRINT_DEC 4, [edx]
    ;NEWLINE
    ;mov eax, dword[p]
    ;mov eax, dword[eax]
    ;PRINT_DEC 4, eax
    ;NEWLINE
    
    
    ;GET_DEC 4, [x]
    ;movsx rcx, dword[x]
    ;mov ecx, dword[x]
    ;mov rax, 1
    ;mov eax, 1
    ;cdq
;.lp:
    ;imul rax, rcx
    ;imul eax, ecx
    ;loop .lp
    
    ;mov dword[p], eax
    ;mov dword[p+4], edx
    
    ;PRINT_DEC 8, rax
    ;PRINT_DEC 8, [p] 
    
    ;NEWLINE
    GET_DEC 4, [x]
    mov ecx, dword[x]
    mov eax, 1
    cdq
    mov ebx, 0
    
.lp:
    cdq
    mul ecx
    imul ebx, ecx
    add ebx, edx
    loop .lp
    
    mov dword[p], eax
    mov dword[p + 4], ebx
    
    PRINT_UDEC 8, [p]
    NEWLINE
    xor rax, rax
    ret