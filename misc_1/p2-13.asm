%include "io.inc"

section .bss
    n resd 1
    arr resd 1000000
    k resd 1
    ft resd 1
    lt resd 1
    prev resd 1
    temp resd 1
    mask resd 1
section .text
global CMAIN
CMAIN:
    GET_DEC 4, [n]
    xor ecx, ecx
.L:
    cmp ecx, dword[n]
    je .EL
    GET_UDEC 4, [arr + 4 * ecx]
    inc ecx
    jmp .L
        
.EL:      
    GET_DEC 4, [k]
       
    xor ecx, ecx
.M:
    cmp ecx, dword[k]
    je .EM
    
    mov edx, 1
    shl edx, cl
    or dword[mask], edx
    inc ecx
    jmp .M 
.EM:      
    xor edi, edi
.PL:
    cmp edi, dword[n]
    je .EPL
    mov eax, dword[arr + 4 * edi]
    and eax, dword[mask]
    mov dword[temp], eax
    mov ecx, dword[k]
    mov eax, dword[arr + 4 * edi]
    shr eax, cl
    mov ebx, dword[prev]
    mov ecx, 32
    sub ecx, dword[k]
    shl ebx, cl
    or eax, ebx
    mov dword[arr + 4 * edi], eax
    mov eax, dword[temp]
    mov dword[prev], eax
    inc edi
    jmp .PL
.EPL:      
    mov eax, dword[prev]
    mov ecx, 32
    sub ecx, dword[k]
    shl eax, cl
    or dword[arr], eax
    
    xor edi, edi
.PR:
    cmp edi, dword[n]
    je .EPR
    PRINT_UDEC 4, [arr + 4 * edi]
    PRINT_CHAR " "
    inc edi
    jmp .PR
                                              
.EPR:                                          
    xor eax, eax
    ret