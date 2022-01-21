%include "io.inc"

section .bss
    n resd 1
    lm resd 500000
    lx resd 500000
    l1 resd 1
    l2 resd 1
    x resd 1
    t1 resd 1
    t2 resd 1
    t3 resd 1

section .text
global CMAIN
CMAIN:
    GET_DEC 4, [n]
    cmp dword[n], 3
    jl .sc
    jmp .nm
.sc:    
    PRINT_CHAR "0"
    NEWLINE
    PRINT_CHAR "0"
    jmp .end
.nm:    
    GET_DEC 4, [t1]
    GET_DEC 4, [t2]
    mov edi, 2
.L:
    cmp edi, dword[n]
    je .EL
    GET_DEC 4, [t3]
    mov edx, dword[t2]
    cmp edx, dword[t1]
    jl .lmc
    je .ni
    cmp edx, dword[t3]
    jle .ni
    mov ecx, dword[l2]
    mov dword[lx + 4 * ecx], edi
    dec dword[lx + 4 * ecx]
    inc dword[l2]
    jmp .ni
.lmc:
    cmp edx, dword[t3]
    jge .ni
    mov ecx, dword[l1]
    mov dword[lm + 4 * ecx], edi
    dec dword[lm + 4 * ecx]
    inc dword[l1]
.ni:
    inc edi
    mov ecx, dword[t2]
    mov dword[t1], ecx
    mov ecx, dword[t3]
    mov dword[t2], ecx
    jmp .L  
              
.EL: 
    PRINT_DEC 4, [l1]
    NEWLINE
    xor ecx, ecx
.LM:
    cmp ecx, dword[l1]
    je .ELM
    PRINT_DEC 4, [lm + 4 * ecx]
    PRINT_CHAR " "
    inc ecx
    jmp .LM
.ELM:  
    cmp dword[l1], 0
    je .wp    
    NEWLINE
.wp:    
    PRINT_DEC 4, [l2]
    NEWLINE
    xor ecx, ecx
.LX:
    cmp ecx, dword[l2]
    je .ELX
    PRINT_DEC 4, [lx + 4 * ecx]
    PRINT_CHAR " "
    inc ecx
    jmp .LX
.ELX:

.end:
    xor eax, eax
    ret