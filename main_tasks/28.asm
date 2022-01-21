%include "io.inc"

section .rodata
    msg db `%d`, 0
    
    
CEXTERN scanf
CEXTERN printf

section .bss
    n resd 1

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msg
    mov dword[esp + 4], n
    call scanf
    
    mov edx, dword[n]
    mov dword[esp], edx
    call G
    
    mov dword[esp], msg
    mov dword[esp + 4], eax
    call printf
    
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
    
G:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov edx, dword[ebp + 8]
    mov dword[esp], edx
    mov dword[esp + 4], 1
    call F
    
        
    mov esp, ebp
    pop ebp
    ret
    
F:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov edx, dword[ebp + 8]
    test edx, edx
    je .triv
    dec edx
    mov dword[esp], edx
    mov eax, dword[ebp + 8]
    xor edx, edx
    imul dword[ebp + 12]
    mov dword[esp + 4], eax
    call F
    jmp .out
          
                
                    
.triv:
    mov eax, 1
.out:    
    mov esp, ebp
    pop ebp
    ret    