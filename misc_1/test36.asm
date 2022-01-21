%include "io64.inc"

section .data
    a dw 0x100, 0x500
    b dd c
    c dd b
    f dd -24
    x dd 137
    y dd 53
    aa dq 0x0b31fe0001fa000a
    
section .text
global CMAIN
CMAIN:
    ;movsx eax, word [a]
    ;add ah, 0xAC
    ;PRINT_HEX 4, eax
    ;NEWLINE
    ;movzx eax, word [c - 1]
    ;PRINT_HEX 4, eax
    ;NEWLINE
    ;PRINT_HEX 4, [c]
    ;NEWLINE
    ;movsx eax, byte [f]
    ;sar eax, 31
    
    ;mov eax, dword [f]
    ;mov ebx, eax
    ;mov ecx, eax
    ;shr ebx, 27
    ;shl ecx, 27
    ;shl eax, 5
    ;shr eax, 5
    ;shr eax, 5
    ;shl eax, 5
    ;add eax, ebx
    ;add eax, ecx
    ;PRINT_DEC 4, eax
    ;NEWLINE
    
    ;neg eax
    ;PRINT_DEC 4, eax
    ;NEWLINE
    
    ;mov eax, dword [x]
    ;sal eax, 5
    ;mov ebx, dword [x]
    ;sar ebx, 3
    ;mov ecx, dword [y]
    ;sal ecx, 28
    ;sar ecx, 28
    ;sub eax, ebx
    ;add eax, ecx
    ;mov dword [y], eax
    ;PRINT_DEC 4, [y]
    ;NEWLINE
    
    ;mov eax, dword [aa]
    ;mov edx, dword [aa + 4]
    ;sal edx, 1
    ;sal eax, 1
    ;adc edx, 0
    ;mov dword [aa], eax
    ;mov dword [aa + 4], edx
    ;PRINT_HEX 8, [aa]
    ;NEWLINE
    
    mov eax, dword [x]
    sar eax, 6
    mov ebx, dword [x]
    sal ebx, 2
    add eax, ebx
    mov dword [y], eax
    PRINT_DEC 4, [y]
    NEWLINE
    xor rax, rax
    ret