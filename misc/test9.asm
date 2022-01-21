%include "io64.inc"

section .data
    a dd -312, -254, 5, 4
    b dw 10, -3, 4, 0
    p db 10, 4, 9, -102
    c dw 250, 5, 2, 253
    q db 4, 10, 253, 11

section .text
global CMAIN
CMAIN:
    mov rbp, rsp; for correct debugging
    ;movsx eax, word [b]
    ;movsx edx, word [b + 2]
    ;add eax, edx
    ;movsx edx, word [b + 4]
    ;sub eax, edx
    ;mov dword [a], eax
    
    ;mov eax, dword [a]
    ;movzx edx, word [c + 6]
    ;add eax, edx
    ;mov byte [p], al
    
    ;movsx eax, byte [p + 2]
    ;movzx edx, byte [q + 3]
    ;add eax, edx
    ;mov word [b], ax
    
    ;mov eax, dword [a]
    ;mov edx, eax
    ;sar edx, 31
    ;idiv dword [a + 4]
    ;mov dword [a], eax
    
    ;mov eax, dword [a + 12]
    ;mov edx, eax
    ;sar edx, 31
    ;movzx ebx, word [c + 4]
    ;idiv ebx
    ;mov dword [a], eax
    
    ;movsx eax, word [b]
    ;movsx edx, word [b + 2]
    ;imul edx
    ;mov dword [a + 4], eax
    
    ;mov eax, dword [a + 4]
    ;mov edx, eax
    ;sar edx, 31
    ;idiv dword [a + 8]
    ;mov dword [a], edx
    
    ;mov eax, dword [a]
    ;mov ebx, dword [a + 4]
    ;mov cl, bl
    ;sal eax, cl
    ;mov dword [a], eax
    
    ;movsx eax, byte [p]
    ;movsx edx, byte [p + 1]
    ;shl edx, 8
    ;or eax, edx
    ;movsx edx, byte [p + 2]
    ;shl edx, 16
    ;or eax, edx
    ;mov dword [a], eax
    
    ;mov eax, dword [a]
    ;mov cl, byte [q]
    ;shl eax, cl
    ;mov edx, dword [a]
    ;mov cl, 32
    ;sub cl, byte [q]
    ;shr edx, cl
    ;or eax, edx
    ;mov dword [a], eax
    
    ;mov eax, dword [a]
    ;sar eax, 31
    ;mov dword [a], eax
    
    movsx eax, word [b + 2]
    mov edx, eax
    sar edx, 31
    movsx ebx, byte [p + 2]
    idiv ebx
    mov dword [a], eax
    PRINT_DEC 4, [a]
    NEWLINE
    ;PRINT_DEC 1, [p + 1]
    xor rax, rax
    ret