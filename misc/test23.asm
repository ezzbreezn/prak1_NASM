%include "io64.inc"



section .text
global CMAIN
CMAIN:
    mov esi, 18
    mov edx, 0
    mov ebx, 2
    cmp ebx, esi
    jnle L2
L1:
    mov eax, esi
    cdq
    idiv ebx
    cmp edx, 0
    je L2
    inc ebx
    cmp esi, ebx
    jne L1
L2:
    cmp edx, 0
    je L3
    mov edx, 1
L3:
    mov eax, edx 
    PRINT_DEC 4, eax
    NEWLINE
    xor rax, rax
    ret