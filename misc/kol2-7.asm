%include "io.inc"

section .rodata
    msgs db `%d`, 0
    msg db `%d %d`, 0
    
CEXTERN scanf
CEXTERN printf

section .bss
    x resd 1
    p resd 1

section .text
global CMAIN
CMAIN:
    ;write your code here
    push ebp
    mov ebp, esp
    sub esp, 16
    
    ;mov dword[esp], msgs
    ;mov dword[esp + 4], x
    ;call scanf
    
    mov dword[p], x
    mov ecx, dword[p]
    mov dword[esp], ecx
    call G
    
    mov dword[esp], msgs
    mov dword[esp + 4], eax
    call printf
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
G:
    push ebp
    mov ebp, esp
    sub esp, 24
    
    mov dword[esp], msg
    lea ecx, [esp + 20]
    mov dword[esp + 4], ecx
    mov ecx, dword[ebp + 8]
    mov dword[esp + 8], ecx
    call scanf
    mov eax, dword[ebp + 8]
    mov eax, dword[eax]
    sub eax, dword[esp + 20]
    
        
    mov esp, ebp
    pop ebp
    ret    