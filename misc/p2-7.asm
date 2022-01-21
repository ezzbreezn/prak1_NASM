%include "io.inc"

section .bss
    n resd 1
    a resd 10000
    

section .text
global CMAIN
CMAIN:
    GET_DEC 4, [n]
    xor ecx, ecx
.L:
    cmp ecx, dword[n]
    je .EL
    GET_DEC 4, [a + 4 * ecx]
    inc ecx
    jmp .L
.EL:
    
    xor ecx, ecx
.B1:
    inc ecx
    cmp ecx, dword[n]
    je .EB1
    dec ecx
    xor edx, edx
.B2:
    mov eax, dword[n]
    dec eax
    sub eax, ecx
    cmp edx, eax
    je .EB2
    mov edi, dword[a + 4 * edx]
    mov esi, dword[a + 4 * edx + 4]
    cmp edi, esi
    jle .next
    mov dword[a + 4 * edx], esi
    mov dword[a + 4 * edx + 4], edi
.next:
    inc edx
    jmp .B2    
.EB2:      
    inc ecx
    jmp .B1      
.EB1:      
    xor ecx, ecx
.P:
    cmp ecx, dword[n]
    je .EP
    PRINT_DEC 4, [a + 4 * ecx]
    PRINT_CHAR " "
    inc ecx
    jmp .P
.EP:                          
    xor eax, eax
    ret