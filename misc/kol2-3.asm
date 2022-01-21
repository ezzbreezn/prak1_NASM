%include "io.inc"

section .rodata
    msg db `%d`, 0

CEXTERN scanf
CEXTERN printf

section .bss
    pa resd 1
    b resd 1
    x resd 1


section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    
    and esp, ~15
    sub esp, 16
    mov dword[esp], msg
    mov dword[esp + 4], b
    call scanf
    
    mov dword[esp + 4], x
    call scanf
    
    mov dword[pa], x
    
    mov ecx, dword[pa]
    mov dword[esp], ecx
    mov ecx, dword[b]
    mov dword[esp + 4], ecx
    call F
    
    mov dword[esp], msg
    mov dword[esp + 4], eax
    call printf
    
    NEWLINE
    
    mov ecx, dword[pa]
    mov ecx, dword[ecx]
    mov dword[esp + 4], ecx
    call printf
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
    
F:
    push ebp
    mov ebp, esp
    sub esp, 4
    
    mov ecx, dword[ebp + 8]
    mov edx, dword[ecx]
    dec dword[ecx]
    mov dword[esp], edx
    mov eax, dword[esp]
    add eax, dword[ebp + 12]
    
    mov esp, ebp
    pop ebp
    ret
    
    
    