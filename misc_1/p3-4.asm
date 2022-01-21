%include "io.inc"


section .text
global CMAIN
CMAIN:
    GET_DEC 4, ecx
    test ecx, ecx
    je .end
    mov edx, 1
    push edx
    push ecx
    call F
    add esp, 8
.end:    
    xor eax, eax
    ret
    
F:
    push ebp
    mov ebp, esp
    
    mov eax, dword[ebp + 8]
    test eax, eax
    je .out
    mov eax, dword[ebp + 12]
    cdq
    mov ecx, 2
    idiv ecx
    test edx, edx
    je .next
    
    PRINT_DEC 4, [ebp + 8]
    PRINT_CHAR " "
    
.next:    
    GET_DEC 4, edx
    mov ecx, dword[ebp + 12]
    inc ecx
    
    push ecx
    push edx
    call F
    add esp, 8

    mov eax, dword[ebp + 12]
    cdq
    mov ecx, 2
    idiv ecx
    test edx, edx
    jne .out
    
    PRINT_DEC 4, [ebp + 8]
    PRINT_CHAR " "
        
        
.out:                        
    mov esp, ebp
    pop ebp
    ret            