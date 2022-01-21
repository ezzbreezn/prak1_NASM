%include "io.inc"

section .bss
    x1 resd 1
    y1 resd 1
    x2 resd 1
    y2 resd 1
    x3 resd 1
    y3 resd 1
    ans resd 1
    area resd 1
    border resd 1

section .text
global CMAIN
CMAIN:
    GET_DEC 4, [x1]
    GET_DEC 4, [y1]
    GET_DEC 4, [x2]
    GET_DEC 4, [y2]
    GET_DEC 4, [x3]
    GET_DEC 4, [y3]
    
    mov eax, dword[x1]
    sub eax, dword[x3]
    
    mov ebx, dword[y2]
    sub ebx, dword[y3]
    
    mul ebx
    
    mov dword[area], eax
    
    mov eax, dword[y1]
    sub eax, dword[y3]
    
    mov ebx, dword[x2]
    sub ebx, dword[x3]
    mul ebx
    
    sub dword[area], eax
    
    mov eax, dword[area]
    
    cmp eax, 0
    jge .skip
    neg eax
.skip:    
    shr eax, 1
    mov dword[area], eax
    
    mov eax, dword[x1]
    sub eax, dword[x2]
    cmp eax, 0
    jge .n1
    neg eax
.n1:    
    
    mov ebx, dword[y1]
    sub ebx, dword[y2]
    cmp ebx, 0
    jge .n2
    neg ebx
.n2:
    push eax
    push ebx
    call GCD
    add esp, 8
    
    dec eax
    add dword[border], eax
    
    mov eax, dword[x2]
    sub eax, dword[x3]
    cmp eax, 0
    jge .n3
    neg eax
.n3:
    mov ebx, dword[y2]
    sub ebx, dword[y3]
    cmp ebx, 0
    jge .n4
    neg ebx
.n4:
    push eax
    push ebx
    call GCD
    add esp, 8
    
    dec eax
    add dword[border], eax
    
    mov eax, dword[x1]
    sub eax, dword[x3]
    cmp eax, 0
    jge .n5
    neg eax
.n5:
    mov ebx, dword[y1]
    sub ebx, dword[y3]
    cmp ebx, 0
    jge .n6
    neg ebx
.n6:
    push eax
    push ebx
    call GCD
    add esp, 8
    dec eax
    add dword[border], eax
    
    add dword[border], 3
    
    mov eax, dword[border]
    shr eax, 1
    mov dword[border], eax
    
    mov eax, dword[area]
    inc eax
    sub eax, dword[border]
    PRINT_UDEC 4, eax                                                                                                                                                
    xor eax, eax
    ret
    
    
GCD:
    push ebp
    mov ebp, esp
    mov eax, dword[ebp + 8]
    mov ebx, dword[ebp + 12]
    cmp eax, ebx
    jg .L
    xchg eax, ebx
.L:    
    test ebx, ebx
    je .EL
    xor edx, edx
    div ebx
    mov eax, ebx
    mov ebx, edx
    jmp .L
.EL:
                
    mov esp, ebp
    pop ebp
    ret            
    
        