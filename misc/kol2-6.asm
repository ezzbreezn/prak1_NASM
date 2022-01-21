%include "io.inc"

section .rodata
    msg db `%d`, 0
    
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
    
    sub esp, 16
    
    mov dword[esp], msg
    mov dword[esp + 4], x
    call scanf
    
    mov dword[esp + 4], y
    call scanf
    
    mov ecx, dword[x]
    mov edx, dword[y]
    call F
    
    mov dword[esp], msg
    mov dword[esp +4 ], eax
    call printf
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
F:
    sub esp, 4
    mov eax, ecx
    mov ecx, edx
    cdq
    idiv ecx
    sar eax, 10
    mov dword[esp], eax
    add esp, 4
    ret    