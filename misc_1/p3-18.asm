%include "io.inc"

section .bss
    a resd 1
    b resd 1
    c resd 1
    r1 resd 1
    r2 resd 1
    r3 resd 1
    ans1 resd 1
    ans2 resd 1
    ans3 resd 1

section .data
    sign dd 1

section .text
global CMAIN
CMAIN:
    GET_DEC 4, [a]
    GET_DEC 4, [b]
    GET_DEC 4, [c]
    cmp dword[a], 0
    jge .next1
    neg dword[a]
    neg dword[sign]
.next1:
    cmp dword[b], 0 
    jge .next2
    neg dword[b]
    neg dword[sign]
.next2:
    cmp dword[c], 0
    jge .next3
    neg dword[c]
    neg dword[sign]
.next3:
    mov eax, dword[a]
    ;cdq
    xor edx, edx
    mul dword[b]
    mov dword[r1], edx
    ;cdq
    xor edx, edx
    mul dword[c]
    mov dword[r2], eax
    mov dword[r3], edx
    mov eax, dword[r1]
    ;cdq
    xor edx,edx
    mul dword[c]
    add eax, dword[r3]
    adc edx, 0
    mov ebx, dword[r2]
    mov dword[ans1], ebx
    mov dword[ans2], eax
    mov dword[ans3], edx
    cmp dword[sign], -1
    jne .L
    
    ;PRINT_CHAR '-'
    
    ;not dword[ans1]
    ;not dword[ans2]
    ;not dword[ans3]
    ;add dword[ans1], 1
    ;adc dword[ans2], 0
    ;adc dword[ans3], 0
.L:
    PRINT_HEX 4, [ans3]
    PRINT_CHAR '|'
    PRINT_HEX 4, [ans2]
    PRINT_CHAR '|'
    PRINT_HEX 4, [ans1]
    NEWLINE
    
    xor eax, eax
    ret