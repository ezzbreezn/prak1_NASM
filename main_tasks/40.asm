%include "io.inc"

section .bss
    i resw 1
    d resd 1
    m resd 1
    y resd 1
    m1 resd 1
    m2 resd 1
    m3 resd 1
    res resw 1
    

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    
    GET_UDEC 2, [i]
    
    movzx eax, word[i]
    
    mov edx, 1
    sal edx, 11
    xor ecx, ecx
.L1:
    cmp ecx, 5
    je .EL1
    or dword[m1], edx
    sal edx, 1
    inc ecx
    jmp .L1
.EL1:    
    mov edx, 1
    sal edx, 7
    xor ecx, ecx
.L2:
    cmp ecx, 4
    je .EL2
    or dword[m2], edx
    sal edx, 1
    inc ecx
    jmp .L2
    
.EL2:
    mov edx, 1
    ;;sal edx, 9
    xor ecx, ecx
.L3:
    cmp ecx, 7
    je .EL3
    or dword[m3], edx
    sal edx, 1
    inc ecx
    jmp .L3
.EL3:
    
    mov ecx, dword[m1]
    and ecx, eax
    shr ecx, 11
    mov dword[d], ecx
    
    mov ecx, dword[m2]
    and ecx, eax
    shr ecx, 7
    mov dword[m], ecx
    
    mov ecx, dword[m3]
    and ecx, eax
    mov dword[y], ecx
    
    PRINT_DEC 4, [d]
    NEWLINE
    PRINT_DEC 4, [m]
    NEWLINE
    PRINT_DEC 4, [y]
    NEWLINE
    cmp dword[m], 1
    jne .n1
    jmp .m1
.n1:
    cmp dword[m], 3
    jne .n2
    jmp .m1
.n2:
    cmp dword[m], 5
    jne .n3
    jmp .m1
.n3:
    cmp dword[m], 7
    jne .n4
    jmp .m1
.n4:
    cmp dword[m], 8
    jne .n5
    jmp .m1
.n5:
    cmp dword[m], 10
    jne .n6
    jmp .m1
.n6:
    cmp dword[m], 12
    jne .n7
    jmp .m11
.n7:
    cmp dword[m], 4
    jne .n8
    jmp .m2
.n8:
    cmp dword[m], 6
    jne .n9
    jmp .m2
.n9:
    cmp dword[m], 9
    jne .n10
    jmp .m2
.n10:
    cmp dword[m], 11
    jne .n11
    jmp .m2
.n11:
    jmp .m3
.m1:
    cmp dword[d], 31
    je .nm1
    inc dword[d]
    jmp .f
.nm1:
    mov dword[d], 1
    inc dword[m]
    jmp .f
.m2:
    cmp dword[d], 30
    je .nm2
    inc dword[d]
    jmp .f
.nm2:
    mov dword[d], 1
    inc dword[m]
    jmp .f
.m3:
    mov eax, dword[y]
    xor edx, edx
    mov ecx, 4
    div ecx
    test edx,edx
    je .vg
    cmp dword[m], 28
    je .nm3
    inc dword[d]
    jmp .f
.nm3:
    mov dword[d], 1
    inc dword[m]
    jmp .f
.vg:
    cmp dword[d], 29
    je .nmv
    inc dword[d]
    jmp .f
.nmv:
    mov dword[d], 1
    inc dword[m]
    jmp .f
.m11:
    cmp dword[d], 31
    je .nm11
    inc dword[d]
    jmp .f
.nm11:
    inc dword[y]
    mov dword[m], 1
    mov dword[d], 1
    jmp .f
.f:
    xor eax, eax
    mov ecx, dword[y]
    or ax, cx
    mov ecx, dword[m]
    sal ecx, 7
    or ax, cx
    mov ecx, dword[d]
    sal ecx, 11
    or ax, cx
    
    
    mov word[res], ax
    
    PRINT_UDEC 2, [res]
        
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret