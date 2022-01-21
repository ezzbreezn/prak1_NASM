%include "io.inc"

section .bss
    f resd 1
    deg resd 1
section .text
global CMAIN
CMAIN:
    ;write your code here
    GET_DEC 4, eax
    mov ecx, 1
    xor ebx, ebx
.L:
    ;cmp ecx, eax
    ;jg .EL
    test ecx, ecx
    je .EL
    test ecx, eax
    je .ni
    cmp dword[f], 1
    je .neg
    mov dword[f], 1
    mov dword[deg], ebx
    jmp .ni
.ni:
    shl ecx, 3
    inc ebx
    jmp .L    
          
.EL:
    mov ecx, 1
    mov edx, dword[deg]
.L1:
    test edx, edx
    je .EL1
    shl ecx, 3
    dec edx
    jmp .L1
.EL1:            
    cmp ecx, eax
    jne .neg
    PRINT_STRING `YES\n`
    
    PRINT_DEC 4, [deg]   
    jmp .out
.neg:
    PRINT_STRING `NO`    
.out:                        
    xor eax, eax
    ret