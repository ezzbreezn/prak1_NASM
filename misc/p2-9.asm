%include "io.inc"

section .bss
    x1 resd 1
    y1 resd 1
    x2 resd 1
    y2 resd 1
    x3 resd 1
    y3 resd 1
    x4 resd 1
    y4 resd 1
    xp resd 1
    yp resd 1

section .text
global CMAIN
CMAIN:
    GET_DEC 4, [x1]
    GET_DEC 4, [y1]
    
    mov eax, dword[x1]
    mov ebx, dword[x1]
    mov ecx, dword[y1]
    mov edx, dword[y1]
    
    GET_DEC 4, [x2]
    GET_DEC 4, [y2]
    
    cmp dword[x2], eax
    cmovl eax, dword[x2]
    cmp dword[x2], ebx
    cmovg ebx, dword[x2]
    cmp dword[y2], ecx
    cmovl ecx, dword[y2]
    cmp dword[y2], edx
    cmovg edx, dword[y2]
    
    GET_DEC 4, [x3]
    GET_DEC 4, [y3]
    
    cmp dword[x3], eax
    cmovl eax, dword[x3]
    cmp dword[x3], ebx
    cmovg ebx, dword[x3]
    cmp dword[y3], ecx
    cmovl ecx, dword[y3]
    cmp dword[y3], edx
    cmovg edx, dword[y3]
    
    GET_DEC 4, [x4]
    GET_DEC 4, [y4]
    
    cmp dword[x4], eax
    cmovl eax, dword[x4]
    cmp dword[x4], ebx
    cmovg ebx, dword[x4]
    cmp dword[y4], ecx
    cmovl ecx, dword[y4]
    cmp dword[y4], edx
    cmovg edx, dword[y4]
    
    GET_DEC 4, [xp]
    GET_DEC 4, [yp]
    
    cmp dword[xp], eax
    jle .out
    cmp dword[xp], ebx
    jge .out
    cmp dword[yp], ecx
    jle .out
    cmp dword[yp], edx
    jge .out
    PRINT_STRING "YES"
    jmp .F
.out:
    PRINT_STRING "NO"
.F: 
    xor eax, eax
    ret