%include "io.inc"

section .bss
    k resd 1
    n resd 1
    a resd 1
    temp resd 1
    ;iter resd 1
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
    mov dword[temp], edx
    xor esi, esi
.L:   
    cmp dword[temp], 1
    je .EL
    cmp dword[temp], 0
    je .EL
          
    mov eax, dword[temp]
    mul dword[temp]
    ;PRINT_DEC 4, [temp]
    ;NEWLINE
    xor ebx, ebx
.L1:
    
    test eax, eax
    je .EL1 
    mov edi, eax
    mov eax, ebx
    mul dword[k]
    mov ebx, eax
    mov eax, edi
    xor edx, edx
    div dword[k]
    add ebx, edx
    jmp .L1    

.EL1:  
    mov eax, ebx  
    
    ;push eax
    ;call PROC
    ;add esp, 4
    xor edx, edx
    div dword[mod]
    mov dword[temp], edx
    
    inc esi
    cmp esi, dword[n]
    jge .EL
    jmp .L
.EL:   
    PRINT_DEC 4, [temp] 
    ;NEWLINE
    ;PRINT_DEC 4, [iter]
    xor eax, eax
    ret
    
PROC:
    push ebp
    mov ebp, esp
    push ebx
    push edi
    
    ;mov dword[iter], 0
    mov eax, dword[ebp + 8]
    cmp eax, 1
    je .EEL
    test eax, eax
    je .EEL
    xor ebx, ebx
.L:
    ;inc dword[iter]
    test eax, eax
    je .EL
    ;mov ecx, eax
    ;xor edx, edx
    ;div dword[ebp + 12]
    ;test edx, edx
    ;jne .skip
    ;test ebx, ebx
    ;jne .skip
    ;;mov eax, ecx
    ;jmp .L
;.skip: 
    ;mov eax, ecx   
    mov edi, eax
    mov eax, ebx
    ;mul dword[ebp + 12]
    mul dword[k]
    mov ebx, eax
    mov eax, edi
;.next:    
    xor edx, edx
    ;div dword[ebp + 12]
    div dword[k]
    add ebx, edx
    jmp .L
                    
.EL:      
    mov eax, ebx
.EEL: 
    ;PRINT_DEC 4, [iter]
    ;NEWLINE         
    mov esp, ebp
    sub esp, 8
    pop edi
    pop ebx
    pop ebp
    ret                