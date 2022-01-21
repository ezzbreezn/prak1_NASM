%include "io.inc"

section .rodata
    msg db `%d`, 0
    
    
CEXTERN scanf
CEXTERN printf


section .bss
    a resd 1
    b resd 1

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
    
    mov edx, dword[a]
    mov dword[esp], edx
    mov edx, dword[b]
    mov dword[esp + 4], edx
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
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    xor edi, edi
    
    mov ecx, dword[ebp + 8]
    mov edx, dword[ebp + 12]
    cmp edx, ecx
    jg .neg
    test ecx, ecx
    je .neg
    test edx, edx
    je .one
    cmp edx, 1
    je .prim
    
    dec ecx
    mov dword[esp], ecx
    mov dword[esp + 4], edx
    call F
    add edi, eax
    
    mov ecx, dword[ebp + 8]
    mov edx, dword[ebp + 12]
    dec ecx
    dec edx
    mov dword[esp], ecx
    mov dword[esp + 4], edx
    call F
    add edi, eax
    mov eax, edi
    jmp .out
    
.prim:
    mov eax, ecx
    jmp .out
        
.one:
    mov eax, 1
    jmp .out    
.neg:
    xor eax, eax
.out:        
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    ret