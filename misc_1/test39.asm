%include "io64.inc"

section .data
    a dd 7
    z dw 0x1ee7

section .text
global CMAIN
CMAIN:
    mov rbp, rsp; for correct debugging
    ;mov eax, dword [a]
    ;mov ebx, dword [a]
    ;neg ebx
    ;shr eax, 31
    ;shr ebx, 31
    ;neg ebx
    ;or eax, ebx
    ;neg eax
    ;PRINT_DEC 4, eax
    ;NEWLINE
    
    ;mov eax, dword [a]
    ;mov ecx, 1
;L1:
    ;test eax, ecx
    ;jz OT
    ;shl ecx, 1
    ;test ecx, ecx
    ;jnz L1
    
;OT:
    ;PRINT_HEX 4, ecx
    ;NEWLINE
    
    ;mov eax, 4
    ;mov ecx, 4
    ;mov edx, 0
    ;idiv ecx
    ;PRINT_DEC 4, eax
    ;NEWLINE
    
    ;mov eax, 0xFA
    
    ;xor edx, edx
    ;cmp eax, 0
    ;jnle L
    ;mov edx, eax
    ;not edx
    ;add edx, eax
;L:
    ;mov ecx, 4
    ;idiv ecx
    ;PRINT_DEC 4, eax
    ;NEWLINE
    
    mov eax, 0x3A700153
    ;mov ecx, 256
    ;imul bx, cx
    ;PRINT_HEX 4, ex
    ;NEWLINE
    mov ecx, 1
    and ecx, eax
    mov ebx, 0x80000000
    imul ebx, ecx
    xor edx, edx
    cmp eax, 0
    jnle L
    mov edx, eax
    not edx
    add edx, eax
L:
    mov ecx, 2
    idiv ecx
    add eax, ebx
    stc
    
    ;xor eax, eax
    ;or ax, word [z]
    ;imul eax, eax, 16
    
    PRINT_HEX 4, eax
    NEWLINE
    xor rax, rax
    ret