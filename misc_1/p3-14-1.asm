%include "io.inc"

section .bss
    k resd 1
    n resd 1
    a resd 1
    t0 resd 1
    t1 resd 1
    temp resd 1

section .data
    mod dd 2011

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, [k]
    GET_UDEC 4, [n]
    GET_UDEC 4, [a]
    mov eax, dword[a]
    xor edx, edx
    div dword[mod]
    mov dword[t0], edx
    mov eax, dword[t0]
    mov ebx, dword[t0]
.L1:
    test eax, eax
    je .EL1
    xor edx, edx
    div dword[k]
    mov dword[temp], eax
    mov eax, ebx
    xor edx, edx
    mul dword[k]
    mov ebx, eax
    mov eax, dword[temp]
    jmp .L1
    
.EL1:
    add ebx, dword[t0]
    mov eax, ebx
    xor edx, edx
    div dword[mod]
    mov dword[t1], edx
    
    ;cmp dword[n], 0
    ;jne .next1
    ;PRINT_UDEC 4, [t0]
    
    ;jmp .end
;.next1:
    cmp dword[n], 1
    jne .next2
    ;PRINT_UDEC 4, [t1]
    jmp .end
.next2:
    
    mov ecx, 1
    
.LP:
    cmp ecx, dword[n]
    je .ELP
    inc ecx
    mov ebx, dword[t1]
    mov eax, dword[t0]
.L2:
    test eax, eax
    je .EL2
    xor edx, edx
    div dword[k]
    mov dword[temp], eax
    mov eax, ebx
    xor edx, edx
    mul dword[k]
    mov ebx, eax
    mov eax, dword[temp]
    jmp .L2
.EL2:
    add ebx, dword[t0]
    mov eax, ebx
    mov ebx, dword[t1]
    mov dword[t0], ebx
    xor edx, edx
    div dword[mod]
    mov dword[t1], edx
    
    jmp .LP
.ELP:    
    
.end:
    PRINT_UDEC 4, [t1]
    

    xor eax, eax
    ret