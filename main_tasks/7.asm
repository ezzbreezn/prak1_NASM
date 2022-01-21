%include "io.inc"

section .rodata
    msg db `%u`, 0
    
CEXTERN scanf
CEXTERN printf    

section .bss
    a resd 1
    b resd 1
    c resd 1


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
    
    push dword[c]
    push dword[b]
    push dword[a]
    call F
    
    mov dword[esp], msg
    mov dword[esp + 4], eax
    call printf
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
F:
    push ebp
    mov ebp,esp
    and esp, ~15
    sub esp, 16
    
    mov eax, dword[ebp + 8]
    and eax, dword[ebp + 12]
    not eax
    mov edx, 1
    mov ecx, dword[ebp + 16]
    sal edx, cl
    and eax, edx
    
        
    mov esp, ebp
    pop ebp
    ret 12   