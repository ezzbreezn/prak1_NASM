%include "io.inc"

section .bss
    n resd 1
    m resd 1
    k resd 1
    m1 resd 10000
    m2 resd 10000
    m3 resd 10000
    d resd 1
    temp resd 1

section .text
global CMAIN
CMAIN:
    GET_DEC 4, [n]
    GET_DEC 4, [m]
    GET_DEC 4, [k]
    mov eax, dword[n]
    mul dword[m]
    mov ecx, eax
    xor ebp, ebp
.L1:
    cmp ebp, ecx
    je .EL1
    GET_DEC 4, [m1 + 4 * ebp]
    inc ebp
    jmp .L1
.EL1:      
    mov eax, dword[m]
    mul dword[k]
    mov ecx, eax
    xor ebp, ebp
.L2:
    cmp ebp, ecx
    je .EL2
    GET_DEC 4, [m2 + 4 * ebp]
    inc ebp
    jmp .L2
.EL2: 
    ;mov eax, dword[n]
    ;mul dword[k]
    ;mov dword[num], eax

    
    xor ecx, ecx          
.M1:
    cmp ecx, dword[n]
    je .EM1

    xor ebp, ebp
.M2:
    cmp ebp, dword[k]
    je .EM2
    xor ebx, ebx
    mov dword[temp], 0
.M3:
    cmp ebx, dword[m]
    je .EM3
    mov eax, ecx
    ;push ebp
    mul dword[m]
    ;pop ebp
    mov edi, eax
    add edi, ebx 

    ;sal edi, 2
    mov eax, ebx
    ;push ebp
    mul dword[k]
    ;pop ebp
    mov esi, eax
    add esi, ebp
    ;PRINT_DEC 4, esi
    ;NEWLINE
    ;sal esi, 2
    mov eax, dword[m1 + 4 * edi]
    mul dword[m2 + 4 * esi]
    add dword[temp], eax
    inc ebx
    jmp .M3
.EM3:      
    mov eax, ecx
    ;push ebp
    mul dword[k]
    ;pop ebp
    add eax, ebp
    ;sal eax, 2
    mov edi, dword[temp]
    mov dword[m3 + 4 * eax], edi
    inc ebp
    jmp .M2      
.EM2:        
    inc ecx
    jmp .M1                                                                                                                                              
.EM1:
           
    xor ecx, ecx
.P1:    
    cmp ecx, dword[n]
    je .EP1
    xor ebp, ebp
.P2:
    cmp ebp, dword[k]
    je .EP2
    mov eax, ecx
    ;push ebp
    mul dword[k]
    ;pop ebp
    add eax, ebp
    sal eax, 2
    PRINT_DEC 4, [m3 + eax]
    PRINT_CHAR " "
    inc ebp
    jmp .P2
.EP2:
    NEWLINE
    inc ecx
    jmp .P1
.EP1:                                                                                                                                                    
    xor eax, eax
    ret