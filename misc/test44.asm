%include "io64.inc"

section .bss
    i resd 1
    q resd 1
    x resd 1
    
section .data
    a dd 4
    b dd 7
    y dd 20
section .text
global CMAIN
CMAIN:
    ;GET_DEC 4, [i]
    ;GET_DEC 4, [b]
    ;GET_DEC 4, [q]
    ;mov ebx, dword[b]
    ;mov edx, dword[q]
    ;mov ecx, dword[i]
    
;.point1:
    ;imul ebx, edx
    ;dec ecx
    ;test ecx, ecx
    ;jne .point1
;.point:
    ;imul ebx, edx
    ;loop .point
    
    ;mov dword[b], ebx
    ;PRINT_DEC 4, [b]
    ;NEWLINE
    
    ;mov eax, dword[a]
    ;mov edx, eax
    ;dec edx
    ;cmp eax, 0
    ;cmovle eax, edx
    ;dec dword[a]
    ;PRINT_DEC 4, [a]
    ;NEWLINE
    ;PRINT_DEC 4, eax
    ;NEWLINE
    
    ;cmp dword[a], 0
    ;jge .u
    ;jmp .pos
;.u:
    ;PRINT_STRING 'hui'
    ;NEWLINE
    ;jmp .pos
;.pos:

    ;mov eax, dword[a]
    ;mov ebx, dword[b]
    ;cmp dword[y], 100
    ;cmovle edx, eax
    ;cmovg edx, ebx
    ;mov dword[x], edx
    ;PRINT_DEC 4, [x]
    ;NEWLINE
    GET_DEC 4, [x]
    mov eax, 1
    cmp dword[x], 0
    jge .nigg
    neg eax
.nigg:
    imul eax, dword[x]
    PRINT_DEC 4, eax
    NEWLINE
    PRINT_DEC 4, [x]
    xor rax, rax
    ret