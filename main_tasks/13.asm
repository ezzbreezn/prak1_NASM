%include "io.inc"

section .rodata
    msg db `%d`, 0
    msgo db `%d `, 0
    
section .bss
    root resd 1
    root1 resd 1
    temp resd 1
    
CEXTERN scanf
CEXTERN printf
CEXTERN malloc
CEXTERN free            

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
.L:
    mov dword[esp], msg
    mov dword[esp + 4], temp
    call scanf
    cmp dword[temp], 0
    je .EL
    
    mov ecx, dword[root]
    mov edx, dword[temp]
    call INSERT
    mov dword[root], eax
    jmp .L
            
    
.EL: 

 
.L1:
    mov dword[esp], msg
    mov dword[esp + 4], temp
    call scanf
    cmp dword[temp], 0
    je .EL1
    
    mov ecx, dword[root1]
    mov edx, dword[temp]
    call INSERT
    mov dword[root1], eax
    jmp .L1
            
    
.EL1:   
    mov ecx, dword[root]
    call PRINT 
    
    ;push dword[root]
    ;call DELETE
    ;add esp, 4
    ;mov dword[root], eax
    NEWLINE
    ;mov dword[esp], msg
    ;mov ecx, dword[root]
    ;mov dword[esp + 4], ecx
    ;call printf
    
    mov ecx, dword[root1]
    call PRINT 
    
    NEWLINE
    
    mov eax, 1
    mov ecx, dword[root]
    mov edx, dword[root1]
    call EQ
    add esp, 8
    mov dword[esp], msgo
    mov dword[esp + 4], eax
    call printf
    
    mov esp, ebp
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
    
    mov edi, ecx
    mov esi, edx
    test edi, edi
    jne .next
    mov dword[esp], 12
    call malloc
    mov dword[eax], esi
    jmp .out
    
.next: 
    cmp dword[edi], edx
    jg .LEFT
    mov edx, esi
    mov ecx, dword[edi + 8]
    call INSERT
    mov dword[edi + 8], eax
    mov eax, edi
    jmp .out
.LEFT:
    mov edx, esi
    mov ecx, dword[edi + 4]
    call INSERT
    mov dword[edi + 4], eax
    mov eax, edi
    jmp .out
.out:       
    mov esp, ebp
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
    
    mov edi, ecx 
    test edi, edi
    je .out
    mov ecx, dword[edi + 4]
    call PRINT
    mov dword[esp], msgo
    mov ecx, dword[edi]
    mov dword[esp + 4], ecx
    call printf
    mov ecx, dword[edi + 8]
    mov dword[esp], ecx
    call PRINT
    
    
.out:    
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    ret
    
DELETE:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    mov edx, dword[ebp + 8]
    test edx, edx
    je .out
    
    mov ecx, dword[edx + 4]
    mov dword[esp], ecx
    call DELETE
    mov edx, dword[ebp + 8]
    mov ecx, dword[edx + 8]
    mov dword[esp], ecx
    call DELETE
    mov edx, dword[ebp + 8]
    mov dword[esp], edx
    call free
    
.out:    
    xor eax, eax
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    ret
    
EQ:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    test eax, eax
    je .NEG
    test ecx, ecx
    je .E
    test edx, edx
    je .NEG
    mov edi, ecx
    mov esi, edx
    mov ecx, dword[edi + 4]
    mov edx, dword[esi + 4]
    call EQ
    
    test eax, eax
    je .NEG
    
    mov ecx, dword[edi + 8]
    mov edx, dword[esi + 8]
    call EQ
    
    test eax, eax
    je .NEG
    
    mov edi, dword[edi]
    mov esi, dword[esi]
    cmp esi, edi
    jne .NEG
    jmp .out
.E:
    test edx, edx
    jne .NEG
    jmp .out
        
.NEG:
    xor eax, eax 
.out:   
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    ret