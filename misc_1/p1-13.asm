%include "io.inc"

section .bss
    x resb 2
    y resb 2
    
section .text
global CMAIN
CMAIN:
    GET_CHAR [x]
    GET_DEC 1, [x + 1]
    GET_CHAR [y]
    GET_CHAR [y]
    GET_DEC 1, [y + 1]
    mov al, byte[x]
    sub al, 'A'
    inc al
    mov byte[x], al
    mov al, byte[y]
    sub al, 'A'
    inc al
    mov byte[y], al    
    movsx eax, byte[x + 1]
    movsx ecx, byte[y + 1]
    sub eax, ecx
    cdq
    imul edx, eax
    add eax, edx
    add eax, edx    
    movsx ebx, byte[x]
    movsx ecx, byte[y]
    sub ebx, ecx
    mov edx, ebx
    sar edx, 31
    imul edx, ebx
    add ebx, edx
    add ebx, edx    
    sub ebx, eax
    sal eax, 1
    add eax, ebx
    PRINT_DEC 4, eax    
    xor eax, eax
    ret