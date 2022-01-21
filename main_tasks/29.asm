%include "io.inc"

section .rodata
    msg db `%d`, 0
    
CEXTERN scanf
CEXTERN printf

section .bss
     a resd 1

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
    
    
    mov edx, dword[a]
    mov dword[esp], edx
    call FOO
    
    mov dword[esp], msg
    mov dword[esp + 4], eax
    call printf

    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
    
FOO:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    ;t -- esp + 12
    lea edx, [esp + 12]
    mov dword[esp + 4], edx
    mov edx, dword[ebp + 8]
    mov dword[esp], edx
    call BAR
    test eax, eax
    je .neg
    mov eax, dword[esp + 12]
    jmp .out
.neg:
    xor eax, eax
.out:
    mov esp, ebp
    pop ebp
    ret
    
BAR:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov eax, dword[ebp + 8]
    xor edx, edx
    mov ecx, 4
    idiv ecx
    test edx, edx
    je .neg
    mov edx, dword[ebp + 12]
    mov dword[edx], 1
    mov eax, 1
    jmp .out
.neg:
    mov edx, dword[ebp + 12]
    mov dword[edx], 0
    xor eax, eax
    
    
.out:    
    mov esp, ebp
    pop ebp
    ret