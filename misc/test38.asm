%include "io64.inc"

section .data
    x dd 0xf2f10204
    y dd 0xA

section .text
global CMAIN
CMAIN:
    mov eax, dword [x]
    mov edx, 0
    mov ecx, 1
    mov ebx, 31
L1:
    test eax, ecx
    jz L2
    bts edx, ebx
L2:
    dec ebx
    shl ecx, 1
    test ecx, ecx
    jnz L1
   
    mov eax, edx
    PRINT_HEX 4, eax
    NEWLINE
    xor rax, rax
    ret