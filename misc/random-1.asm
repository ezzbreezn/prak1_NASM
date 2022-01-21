%include "io.inc"

section .rodata
    msg db `%d%d`, 0
    msgo db `%d %d`, 0
    
CEXTERN scanf
CEXTERN printf

section .bss
    x resd 1
    y resd 1

section .text
global CMAIN
CMAIN:
    ;write your code here
    push ebp
    mov ebp, esp
    sub esp, 24
    
    mov dword[esp], msg
    mov dword[esp + 4], x
    mov dword[esp + 8], y
    call scanf
    
    sal dword[x], 1
    sal dword[y], 2
    
    mov dword[esp], msgo
    mov ecx, dword[x]
    mov dword[esp + 4], ecx
    mov ecx, dword[y]
    mov dword[esp + 8], ecx
    call printf
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret