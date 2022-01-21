%include "io.inc"


section .text
global CMAIN
CMAIN:
    ;write your code here
    call F
    PRINT_DEC 4, eax
    xor eax, eax
    ret
    
F:
    push ebp
    mov ebp, esp
    sub esp, 4
    GET_CHAR cl
    cmp cl, '.'
    je .pout
    sub cl, '0'
    cmp cl, 0
    jge .next
    jmp .ni
.next:
    cmp cl, 9
    jg .ni
    mov dword[esp], 1
    jmp .nc
.ni:
    mov dword[esp], 0
.nc:
    call F
    add eax, dword[esp]        
    jmp .out
.pout:
    xor eax, eax
              
.out:         
    mov esp, ebp
    pop ebp
    ret    