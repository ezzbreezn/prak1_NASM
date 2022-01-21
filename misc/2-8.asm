%include "io.inc"

section .bss
    n resd 1
    m resd 1
    k resd 1
    a resd 10000
    b resd 10000
    c resd 10000
    x resd 1
    c1 resd 1
    c2 resd 1
    t resd 1

section .text
global CMAIN
CMAIN:
    ;write your code here
    GET_DEC 4, [n]
    GET_DEC 4, [m]
    GET_DEC 4, [k]
    xor edi, edi
.l1:
    cmp edi, dword[n]
    je .el1
    xor esi, esi
.sl1:
    cmp esi, dword[m]
    je .esl1    
    GET_DEC 4, [x]
    mov eax, dword[m]
    xor edx, edx
    mul edi
    sal eax, 2
    mov ecx, esi
    sal ecx, 2
    add eax, ecx
    mov ecx, dword[x]
    mov dword[a + eax], ecx
    inc esi
    jmp .sl1
.esl1:    
    inc edi
    jmp .l1
.el1:    
    xor edi, edi
.l2:
    cmp edi, dword[m]
    je .el2
    xor esi, esi
.sl2:
    cmp esi, dword[k]
    je .esl2
    GET_DEC 4, [x]
    mov eax, dword[k]
    xor edx, edx
    mul edi
    sal eax, 2
    mov ecx, esi
    sal ecx, 2
    add eax, ecx
    mov ecx, dword[x]
    mov dword[b + eax],ecx
    inc esi
    jmp .sl2
.esl2:    
    inc edi
    jmp .l2
.el2:

    mov eax, dword[m]
    sal eax, 2
    mov dword[c1], eax

    mov eax, dword[k]
    sal eax, 2
    mov dword[c2], eax
    
    


    xor edi, edi
.m1:
    cmp edi, dword[n]
    je .em1
    xor esi, esi
 .mm1:  
    cmp esi, dword[k]
    je .emm1
    mov dword[x], 0
    xor ecx, ecx
.m2:    
    cmp ecx, dword[m]
    je .em2
    mov eax, dword[c1]
    xor edx, edx
    mul edi
    lea eax, [eax + 4 * ecx]
    mov edx, dword[a + eax]
    mov dword[t], edx
    mov eax, dword[c2]
    xor edx, edx
    mul ecx
    lea eax, [eax + 4 * esi]
    mov eax, dword[b + eax]
    xor edx, edx
    mul dword[t]
    add dword[x], eax
    inc ecx
    jmp .m2
.em2:    
    mov eax, dword[c2]
    xor edx, edx
    mul edi
    mov edx, esi
    sal edx, 2
    add eax, edx
    mov edx, dword[x]
    mov dword[c + eax], edx
    
    inc esi
    jmp .mm1
    
.emm1:    
    inc edi
    jmp .m1
.em1:

    xor edi, edi
.o1:
    cmp edi, dword[n]
    je .eo1
    xor esi, esi    
.o2:
    cmp esi, dword[k]
    je .eo2
    mov eax, dword[k]
    xor edx, edx
    mul edi
    add eax, esi
    sal eax, 2
    PRINT_DEC 4, [c + eax]
    PRINT_CHAR ' '
    inc esi
    jmp .o2
.eo2:      
    NEWLINE
    inc edi
    jmp .o1      
    
.eo1:
    xor eax, eax
    ret