%include "io.inc"

section .bss
    n resd 1
    x resd 1
    y resd 1
    c resd 1
    z resd 1
    d1 resd 1
    d2 resd 1
    lcm resd 1
    t resd 1

section .text
global CMAIN
CMAIN:
    ;write your code here
    GET_DEC 4, [n]
    xor edi, edi
.L:
    cmp edi, dword[n]
    je .EL
    GET_DEC 4, [x]
    GET_DEC 4, [y]
    cmp edi, 0
    jne .next
    mov edx, dword[x]
    mov dword[c], edx
    mov edx, dword[y]
    mov dword[z], edx
    inc edi
    jmp .L
    
    
.next:
    push dword[z]
    push dword[y]
    call LCM
    add esp, 8
    mov dword[lcm], eax
    xor edx,edx
    div dword[z]
    mov dword[d1], eax    
    mov ebx, dword[lcm]
    mov dword[z], ebx
    mov eax, dword[c]
    xor edx, edx
    mul dword[d1]
    mov dword[c], eax
    mov eax, dword[lcm]
    xor edx,edx
    div dword[y]
    mov dword[d2], eax
    mov eax, dword[x]
    xor edx, edx
    mul dword[d2]
    add dword[c], eax
    push dword[c]
    push dword[z]
    call GCD
    add esp, 8
    mov dword[t], eax
    mov eax, dword[z]
    xor edx, edx
    div dword[t]
    mov dword[z], eax
    mov eax, dword[c]
    xor edx, edx
    div dword[t]
    mov dword[c], eax
    inc edi
    jmp .L
.EL:
    PRINT_UDEC 4, [c]
    PRINT_CHAR ' '
    PRINT_UDEC 4, [z]
        
    xor eax, eax
    ret
    
    
GCD:
    push ebp
    mov ebp, esp
    
    mov eax, dword[ebp + 8]
    mov ecx, dword[ebp + 12]
    cmp eax, ecx
    jge .skip
    xchg eax, ecx
    
    
.skip:        
    
.L:
    test ecx, ecx
    je .EL
    xor edx, edx
    div ecx
    mov eax, ecx
    mov ecx, edx
    jmp .L
        
.EL:
   ; PRINT_DEC 4, eax
   ; NEWLINE            
    mov esp, ebp
    pop ebp
    ret 
    
LCM:
    push ebp
    mov ebp, esp
    
    push dword[ebp + 8]
    push dword[ebp + 12]
    call GCD
    add esp, 8
    
    mov ecx, eax
    mov eax, dword[ebp + 8]
    xor edx, edx
    mul dword[ebp + 12]
    div ecx
    
          
    mov esp, ebp
    pop ebp
    ret   