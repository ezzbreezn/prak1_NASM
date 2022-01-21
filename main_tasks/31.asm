%include "io.inc"

section .rodata
    msg db `%hi`, 0
    msgl db `%lld`, 0
    
CEXTERN scanf
CEXTERN printf

section .bss
    a resw 1
    b resw 1

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msg
    mov dword[esp + 4], a
    call scanf
    
    mov dword[esp], msg
    mov dword[esp + 4], b
    call scanf
    
    movsx edx, word[a]
    movsx ecx, word[b]
    
    mov dword[esp], edx
    mov dword[esp + 4], ecx
    call F
    
    mov dword[esp + 4], eax
    mov dword[esp + 8], edx
    mov dword[esp], msgl
    call printf
    
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    xor eax, eax
    ret
    
F:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    movsx eax, word[ebp + 8]
    movsx ecx, word[ebp + 12]
    xor edx, edx
    add eax, ecx
    adc edx, 0
    
    mov esp, ebp
    pop ebp
    ret