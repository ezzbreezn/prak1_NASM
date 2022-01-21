%include "io.inc"

section .rodata
    msg db `%s`, 0
    
CEXTERN printf
CEXTERN malloc
CEXTERN free
CEXTERN time
CEXTERN ctime
CEXTERN puts

section .bss
    t resd 2

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], 0
    call time
    
    mov dword[esp + 12], eax
    lea eax, [esp + 12]
    mov dword[esp], eax
    call ctime
    
    mov dword[esp], eax
    call puts
    mov esp, ebp
    pop ebp
    ret
    xor eax, eax
    ret