%include "io.inc"

section .rodata
    msg db `%d` ,0
    msg0 db `%d `, 0
    
section .bss
    a resd 1
    b resd 1
    c resd 1
    
CEXTERN scanf
CEXTERN printf


section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msg
    mov dword[esp + 4], a
    call scanf
    
    mov dword[esp], msg
    mov dword[esp + 4], b
    call scanf
    
    mov dword[esp], msg
    mov dword[esp + 4], c
    call scanf
    
    mov edx, dword[a]
    mov dword[esp], edx
    mov edx, dword[b]
    mov dword[esp + 4], edx
    mov edx, dword[c]
    mov dword[esp + 8], edx
    call WRAPPER
    
    mov dword[esp], msg
    mov dword[esp + 4], eax
    call printf
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
    
ACTUAL:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov eax, dword[ebp + 8]
    add eax, dword[ebp + 12]
    add eax, dword[ebp + 16]
    
    mov esp, ebp
    pop ebp
    ret
    
WRAPPER:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    mov edx, dword[ebp + 8]
    mov dword[esp], edx
    mov edx, dword[ebp + 12]
    mov dword[esp + 4], edx
    mov edx, dword[ebp + 16]
    mov dword[esp + 8], edx
    call ACTUAL
    mov esp, ebp
    pop ebp
    ret