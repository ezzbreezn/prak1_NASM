%include "io.inc"

section .bss
    x resd 1
    i resd 1


section .data
    xi dd 12
    v dd 1, 2, 3, 4, 5, 6, 7, 8, 9, 10

section .text
global CMAIN
CMAIN:
    ;write your code here
    mov dword[i], 8
    mov dword[x], xi
    
    cmp dword[i], 10
    jl .next
    mov dword[i], 0
    xor eax, eax
    jmp .out
.next:
    mov ecx, dword[i]
    mov eax, dword[v + 4 * ecx]
    shr eax, 13
    mov edx, dword[v + 4 * ecx]
    shl edx, 19
    or eax, edx
    mov edx, dword[x]
    xor dword[x], eax
    mov eax, dword[i]
    inc dword[i]
.out:
    PRINT_DEC 4, eax
    xor eax, eax
    ret
    
