%include "io64.inc"

section .data
    x dd 0xf2f10204

section .text
global CMAIN
CMAIN:
    ;mov cx, word [x + 1]
    ;mov ax, cx
    ;imul ah
    ;shl ax, cl
    ;movsx eax, ax
    ;movzx edx, ax
    ;PRINT_HEX 4, eax
    ;NEWLINE
    ;PRINT_HEX 4, edx
    ;NEWLINE
    ;popcnt eax, dword [x]
    ;PRINT_DEC 4, eax
    ;NEWLINE
    
    ;mov ecx, 0x80000000
    ;mov ebx, 0
;L1:
    ;test dword [x], ecx
    ;jz L2
    ;inc ebx
;L2:
    ;shr ecx, 1
    ;test ecx, ecx
    ;jnz L1
    
    ;popcnt ebx, dword [x]
    
    ;PRINT_DEC 4, ebx
    ;NEWLINE
    
    mov ecx, 0x80000000
    mov ebx, 0
L1:
    test dword [x], ecx
    jnz L3
    xor ebx, ebx
L2:
    shr ecx, 1
    test ecx, ecx
    jnz L1
    jz OT
L3:
    inc ebx
    cmp ebx, 5
    je OT
    jmp L2
OT:
    cmp ebx, 5
    je C1
    xor ebx, ebx
    jmp PRINT
C1:
    mov ebx, 1
PRINT:
    mov eax, ebx
    PRINT_DEC 4, eax
    NEWLINE
    
    test dword [x], 1
    jz EVEN
    jmp NOT_EVEN
EVEN:
    PRINT_DEC 4, 1
    NEWLINE
NOT_EVEN:
    xor rax, rax
    ret