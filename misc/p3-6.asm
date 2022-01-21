%include "io.inc"

section .bss
    n resd 1
    x resd 1000
    k resd 1
    ans resd 1

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, [n]
    xor edi, edi
.L:
    cmp edi, dword[n]
    je .EL
    GET_UDEC 4, [x + 4 * edi]
    ;push dword[x]
    ;call MN
    ;add esp, 4
    ;cmp eax, dword[k]
    ;jne .next
    ;inc dword[ans]
;.next:
    inc edi
    jmp .L    
    
.EL:  
    GET_UDEC 4, [k]
    xor edi, edi
.LL:
    cmp edi, dword[n]
    je .ELL
    push dword[x + 4 * edi]
    call MN
    add esp, 4
    cmp eax, dword[k]
    jne .next
    inc dword[ans]
.next:
    inc edi
    jmp .LL    

.ELL:
    PRINT_UDEC 4, [ans]     
    xor eax, eax
    ret
    
MN:
    push ebp
    mov ebp, esp
    push edi
        
    xor edx, edx    
    mov ecx, 1
    shl ecx, 31
    mov eax, dword[ebp + 8]
.W:
    test ecx, eax
    jne .EW
    test ecx, ecx
    je .EW
    shr ecx , 1
    jmp .W
.EW:
    shr ecx, 1
.WW:    
    test ecx, ecx
    je .EEW
    test ecx, eax
    jne .skip
    inc edx
.skip:
    shr ecx, 1
    jmp .WW
.EEW:    
    mov eax, edx                  
            
    mov esp, ebp
    sub esp, 4
    pop edi
    pop ebp
    ret                