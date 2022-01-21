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
    
    push dword[temp]
    push dword[root]
    call INSERT
    mov dword[root], eax
    add esp, 8
    jmp .L
            
    
.EL: 

 
.L1:
    mov dword[esp], msg
    mov dword[esp + 4], temp
    call scanf
    cmp dword[temp], 0
    je .EL1
    
    push dword[temp]
    push dword[root1]
    call INSERT
    mov dword[root1], eax
    add esp, 8
    jmp .L1
            
    
.EL1:   
    push dword[root]
    call PRINT
    add esp, 4 
    
    ;push dword[root]
    ;call DELETE
    ;add esp, 4
    ;mov dword[root], eax
    NEWLINE
    ;mov dword[esp], msg
    ;mov ecx, dword[root]
    ;mov dword[esp + 4], ecx
    ;call printf
    
    push dword[root1]
    call PRINT
    add esp, 4 
    
    NEWLINE
    
    mov eax, 1
    push dword[root1]
    push dword[root]
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
    
    mov edi, dword[ebp + 8]
    test edi, edi
    jne .next
    mov dword[esp], 12
    call malloc
    mov ecx, dword[ebp + 12]
    mov dword[eax], ecx
    jmp .out
    
.next: 
    mov ecx, dword[ebp + 12]
    cmp dword[edi], ecx
    jg .LEFT
    mov edx, dword[edi + 8]
    mov dword[esp], edx
    mov edx, dword[ebp + 12]
    mov dword[esp + 4], edx
    call INSERT
    mov dword[edi + 8], eax
    mov eax, dword[ebp + 8]
    jmp .out
.LEFT:
    mov edx, dword[edi + 4]
    mov dword[esp], edx
    mov edx, dword[ebp + 12]
    mov dword[esp + 4], edx
    call INSERT
    mov dword[edi + 4], eax
    mov eax, dword[ebp + 8]
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
    
    mov edx, dword[ebp + 8]
    test edx, edx
    je .out
    mov ecx, dword[edx + 4]
    mov dword[esp], ecx
    call PRINT
    mov edx, dword[ebp + 8]
    mov dword[esp], msgo
    mov ecx, dword[edx]
    mov dword[esp + 4], ecx
    call printf
    mov edx, dword[ebp + 8]
    mov ecx, dword[edx + 8]
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
    mov edx, dword[ebp + 8]
    mov ecx, dword[ebp + 12]
    test edx, edx
    je .E
    test ecx, ecx
    je .NEG
    
    mov edi, dword[edx + 4]
    mov esi, dword[ecx + 4]
    mov dword[esp], edi
    mov dword[esp + 4], esi
    call EQ
    
    test eax, eax
    je .NEG
    
    mov edx, dword[ebp + 8]
    mov ecx, dword[ebp + 12]
    mov edi, dword[edx + 8]
    mov esi, dword[ecx + 8]
    mov dword[esp], edi
    mov dword[esp + 4], esi
    call EQ
    
    test eax, eax
    je .NEG
    
    mov edx, dword[ebp + 8]
    mov ecx, dword[ebp + 12]
    mov edi, dword[edx]
    mov esi, dword[ecx]
    cmp esi, edi
    jne .NEG
    jmp .out
.E:
    test ecx, ecx
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