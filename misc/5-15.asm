%include "io64.inc"

section .bss
    x resd 1

section .data
    v dd 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    N dd 10
    i dd 5
    a dd 5

section .text
global CMAIN
CMAIN:
    mov dword[x], a
    
    mov eax, dword [i]
    cmp eax, dword[N]
    jnle .P1
    mov edx, dword[x]
    mov ebx, dword[v + 4 * eax]
    mov ecx, ebx
    shr ecx, 13
    mov eax, ebx
    shl eax, 19
    or ecx, eax
    xor dword[edx], ecx
    inc dword[i]
    jmp .P2
.P1:
    mov dword[i], 0
.P2:
    PRINT_DEC 4, [i]
    NEWLINE
    mov eax, dword[x]
    mov eax, dword[eax]
    PRINT_DEC 4, eax
    NEWLINE
    PRINT_CHAR 0DBh
    NEWLINE
    xor rax, rax
    ret