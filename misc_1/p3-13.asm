%include "io.inc"

section .bss
    n resd 1
    k resd 1
    m resd 1
    a resd 10
    used resd 10
    count resd 1

section .text
global CMAIN
CMAIN:
    GET_DEC 4, [n]
    GET_DEC 4, [k]
    GET_DEC 4, [m]
    mov ecx, 1
.I:
    cmp ecx, dword[k]
    jg .EI
    mov dword[a + 4 * ecx - 4], ecx
    mov dword[used + 4 * ecx - 4], 1
    inc ecx
    jmp .I
.EI:
     
    mov edi, 1
.L:
    cmp edi, dword[m]
    je .EL
    mov ecx, dword[k]
    dec ecx
    push ecx
    call F
    add esp, 4
    inc edi
    jmp .L
                            
.EL:   
    
    xor edi, edi
.P:
    cmp edi, dword[k]
    je .EP    
    PRINT_DEC 4, [a + 4 * edi]
    PRINT_CHAR " "
    inc edi
    jmp .P      
                                              
.EP:                                         
    xor eax, eax
    ret
    
    
F:
    push ebp
    mov ebp, esp
    push edi
    mov ecx, dword[ebp + 8]
    mov ecx, dword[a + 4 * ecx]
    ;inc ecx
.L:
    cmp ecx, dword[n]
    jge .EL     
    cmp dword[used + 4 * ecx], 0
    je .EL    
    inc ecx
    jmp .L        
.EL:      
    cmp ecx, dword[n]
    jl .next
    mov ecx, dword[ebp + 8]
    mov ecx, dword[a + 4 * ecx]
    dec ecx
    mov dword[used + 4 * ecx], 0
    mov ecx, dword[ebp + 8]
    dec ecx
    ;mov edx, dword[ebp + 12]
    ;push edx
    push ecx
    call F
    add esp, 8
    xor ecx, ecx
.LN:
    cmp ecx, dword[n]
    jge .ELN
    cmp dword[used + 4 * ecx], 0
    je .ELN
    inc ecx
    jmp .LN   
.ELN: 
    mov dword[used + 4 * ecx], 1
    mov edx, ecx
    inc edx
    mov ecx, dword[ebp + 8]
    mov dword[a + 4 * ecx], edx
    jmp .out   
.next:  
    mov edx, dword[ebp + 8]
    mov edx, dword[a + 4 * edx]
    dec edx
    mov dword[used + 4 * edx], 0
    mov dword[used + 4 * ecx], 1
    inc ecx
    mov edx, dword[ebp + 8]
    mov dword[a + 4 * edx], ecx
    
  
.out:      
    mov esp, ebp
    sub esp, 4
    pop edi
    pop ebp
    ret    