%include "io.inc"

section .bss
    m1 resd 1
    m2 resd 1
    m3 resd 1
    x resd 1
    n resd 1

section .text
global CMAIN
CMAIN:
    GET_DEC 4, [n]
    

    GET_DEC 4, [m1]
    
    GET_DEC 4, [m2]
    mov ecx, dword[m2]
    cmp ecx, dword[m1]
    jle .s1
    mov edx, dword[m1]
    mov dword[m1], ecx
    mov dword[m2], edx
.s1:
    GET_DEC 4, [m3]
    mov ecx, dword[m3]
    cmp ecx, dword[m1]
    jle .s2
    mov edx, dword[m2]
    mov dword[m3], edx
    mov edx, dword[m1]
    mov dword[m2], edx
    mov dword[m1], ecx
    jmp .s3
.s2:
    cmp ecx, dword[m2]
    jle .s3
    mov edx, dword[m2]
    mov dword[m3], edx
    mov dword[m2], ecx
.s3:    
    mov edi, 3
.L:
    cmp edi, dword[n]
    je .EL
    GET_DEC 4, edx
    cmp edx, dword[m1]
    jle .n1
    mov ecx, dword[m2]
    mov dword[m3], ecx
    mov ecx, dword[m1]
    mov dword[m2], ecx
    mov dword[m1], edx
    jmp .ns
.n1:    
    cmp edx, dword[m2]
    jle .n2
    mov ecx, dword[m2]
    mov dword[m3], ecx
    mov dword[m2], edx
    jmp .ns
.n2:
    cmp edx, dword[m3]
    jle .ns
    mov dword[m3], edx
.ns:
    inc edi
    jmp .L        
                        
.EL:                                                                
    PRINT_DEC 4, [m1]
    PRINT_CHAR " "
    PRINT_DEC 4, [m2]
    PRINT_CHAR " "
    PRINT_DEC 4, [m3]
    
            
    
    xor eax, eax
    ret