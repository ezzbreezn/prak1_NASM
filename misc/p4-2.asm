%include "io.inc"

section .rodata
    msg db `%s`, 0
    msg1 db `1 2`, 0
    msg2 db `2 1`, 0
    msg0 db `0`, 0    
section .bss
    s1 resb 1002
    s2 resb 1002 
            
CEXTERN scanf
CEXTERN printf
CEXTERN strstr    

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msg
    mov dword[esp + 4], s1
    call scanf
    
    mov dword[esp], msg
    mov dword[esp + 4], s2
    call scanf
    
    mov dword[esp], s1
    mov dword[esp + 4], s2
    call strstr
    
    test eax, eax
    je .next
    
    mov dword[esp], msg2
    call printf
    jmp .end
.next:

    mov dword[esp], s2
    mov dword[esp + 4], s1
    call strstr
    
    test eax, eax
    je .def
    
    mov dword[esp], msg1
    call printf
    jmp .end        
.def:
    mov dword[esp], msg0
    call printf
        
    
.end:    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret