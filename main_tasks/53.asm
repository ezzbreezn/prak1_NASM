%include "io.inc"

section .rodata
    msgd db `%d`, 0
    msgo db `%d `, 0
    msgc db `%c`, 0
    pa db `YES\n`, 0
    na db `NO\n`, 0
    nl db `\n`, 0
    
CEXTERN scanf
CEXTERN printf
CEXTERN malloc
CEXTERN free
CEXTERN getchar

section .bss
    root resd 1
    temp resd 1
    c resb 1
    n resd 1

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    push edi
    push esi
    push ebx
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msgd
    mov dword[esp + 4], n
    call scanf
    
    xor edi, edi
.L:
    cmp edi, dword[n]
    je .EL
    mov dword[esp], msgd
    mov dword[esp + 4], temp
    call scanf
    
    mov edx, dword[root]
    mov dword[esp], edx
    mov edx, dword[temp]
    mov dword[esp + 4], edx
    call INSERT
    mov dword[root], eax
    
    inc edi
    jmp .L
.EL:


    mov dword[esp], msgd
    mov dword[esp + 4], n
    call scanf
    xor edi, edi
    mov dword[esp] , msgc
    mov dword[esp + 4], c
    call scanf
.L1: 
    cmp edi, dword[n]
    je .EL1
    mov dword[esp] , msgc
    mov dword[esp + 4], c
    call scanf
    cmp byte[c], 'A'
    je .a
    cmp byte[c], 'S'
    je .s
    cmp byte[c], 'D'
    je .d
    jmp .ni
.a:
    mov dword[esp],msgd
    mov dword[esp + 4], temp
    call scanf
    mov edx, dword[root]
    mov dword[esp], edx
    mov edx, dword[temp]
    mov dword[esp + 4], edx
    call INSERT
    mov dword[root], eax
    jmp .ni
.s:
    mov dword[esp],msgd
    mov dword[esp + 4], temp
    call scanf
    mov edx, dword[root]
    mov dword[esp], edx
    mov edx, dword[temp]
    mov dword[esp + 4], edx
    call SEARCH
    test eax, eax
    je .neg
    mov esi, dword[eax]
    mov dword[esp], pa
    call printf
    mov dword[esp], msgd
    mov dword[esp + 4], esi
    call printf
    mov dword[esp], nl
    call printf
    jmp .ni
.neg:
    mov dword[esp], na
    call printf
    jmp .ni
.d:
    mov dword[esp],msgd
    mov dword[esp + 4], temp
    call scanf
    mov edx, dword[root]
    mov dword[esp], edx
    mov edx, dword[temp]
    mov dword[esp + 4], edx 
    call DELETE
    mov dword[root], eax
    jmp .ni

.ni:
    mov dword[esp] , msgc
    mov dword[esp + 4], c
    call scanf

    inc edi
    jmp .L1
.EL1:    





    mov edx, dword[root]
    mov dword[esp], edx
    call PRINT    
    mov esp, ebp
    sub esp, 12
    pop ebx
    pop esi
    pop edi
    pop ebp
    xor eax, eax
    ret
    
    
    
    
    
INSERT: 
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    mov edx, dword[ebp + 8]
    test edx, edx
    jne .n0
    mov dword[esp], 8
    call malloc
    mov edx, dword[ebp + 12]
    mov dword[eax], edx
    mov dword[eax + 4], 0
    jmp .out
.n0:
    mov ecx, dword[ebp + 12]
    cmp dword[edx], ecx
    jle .n1
    mov dword[esp], 8
    call malloc
    mov edx, dword[ebp + 12]
    mov dword[eax], edx
    mov edx, dword[ebp + 8]
    mov dword[eax + 4], edx
    jmp .out    
    
    
.n1:
    cmp dword[edx + 4], 0
    jne .n2
    mov ecx, dword[ebp + 12]
    cmp dword[edx], ecx
    jg .n3
    mov dword[esp], 8
    call malloc
    mov ecx, dword[ebp + 12]
    mov dword[eax], ecx
    mov edx, dword[ebp+ 8]
    mov dword[edx + 4], eax
    mov eax, edx
    jmp .out
.n3:
    mov dword[esp], 8
    call malloc
    mov ecx, dword[ebp + 12]
    mov dword[eax], ecx
    mov edx, dword[ebp + 8]
    mov dword[eax + 4], edx
    jmp .out
.n2:
    mov ecx, dword[ebp + 12]
    mov edx, dword[edx + 4]

    cmp ecx, dword[edx]
    jle .n4
    mov dword[esp], edx
    mov ecx, dword[ebp + 12]
    mov dword[esp + 4], ecx
    call INSERT
    mov edx, dword[ebp + 8]
    mov dword[edx + 4], eax
    mov eax, edx
    jmp .out
.n4:
    mov dword[esp], 8
    call malloc
    mov ecx, dword[ebp + 12]
    mov dword[eax], ecx
    mov edx, dword[ebp + 8]
    mov edi, dword[edx + 4]
    mov dword[eax + 4], edi
    mov dword[edx + 4], eax
    mov eax, edx
    
        
    
.out:
    mov esp,ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    ret
    
PRINT:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    cmp dword[ebp + 8], 0
    je .out
    mov edx, dword[ebp + 8]
    mov edi, dword[edx + 4]
    mov dword[esp], msgo
    mov edx, dword[edx]
    mov dword[esp + 4], edx
    call printf
    
    mov dword[esp], edi
    call PRINT
    
    
.out:    
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    ret
    
    
SEARCH:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov edx, dword[ebp + 8]
    test edx, edx
    jne .n1
    xor eax, eax
    jmp .out
.n1:
    mov ecx, dword[ebp + 12]
    cmp ecx, dword[edx]
    jne .n2
    mov eax, edx
    jmp .out
.n2:
    mov edx, dword[edx + 4]
    mov dword[esp], edx
    mov ecx, dword[ebp + 12]
    mov dword[esp + 4], ecx
    call SEARCH        
.out:            
    mov esp, ebp
    pop ebp
    ret    
    
    
DELETE:
    push ebp
    mov ebp, esp
    push edi
    and esp, ~15
    sub esp, 16
    
    cmp dword[ebp + 8], 0
    jne .n1
    xor eax, eax
    jmp .out
.n1:
    mov edx, dword[ebp + 8]
    mov ecx, dword[ebp + 12]
    cmp ecx, dword[edx]
    je .n2
    mov edx, dword[edx + 4]
    mov dword[esp], edx
    mov dword[esp + 4], ecx
    call DELETE
    mov edx, dword[ebp + 8]
    mov dword[edx + 4], eax
    mov eax, edx
    jmp .out
.n2:        
    cmp dword[edx + 4], 0
    je .n3
    mov edi, dword[edx + 4]
    mov dword[esp], edx
    call free
    mov eax, edi
    jmp .out
.n3:
    mov dword[esp], edx
    call free
    xor eax, eax
    
.out:    
    mov esp, ebp
    sub esp, 4
    pop edi
    pop ebp
    ret