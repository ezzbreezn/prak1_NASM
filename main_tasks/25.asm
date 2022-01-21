%include "io.inc"

section .rodata
    msgs db `%s`, 0
    fin db `/home/boris/prak/asm/sassasm/input.bin`, 0
    rmode db `rb`, 0
    
CEXTERN fread
CEXTERN fopen
CEXTERN fclose
CEXTERN malloc
CEXTERN free


section .bss
    s resb 1000
    res resd 1
    len resd 1
    f resd 1

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], fin
    mov dword[esp + 4], rmode
    call fopen
    
    mov dword[f], eax
    
    mov dword[esp], eax
    call F
    
    mov dword[res], eax
    
    mov dword[esp],msgs
    mov edx, dword[res]
    mov dword[esp + 4], edx
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
    push edi
    push esi
    and esp, ~15
    sub esp, 32
    
    lea edx, [esp + 16]
    mov dword[esp], edx
    mov dword[esp + 4], 4
    mov dword[esp + 8], 1
    mov edx, dword[ebp + 8]
    mov dword[esp + 12], edx
    call fread
    
    mov edi, dword[esp + 16]
    
    mov dword[esp], edi
    call malloc
    
    mov esi, eax
    
    mov dword[esp + 28], edi
    xor edi, edi
.L:
    cmp edi, dword[esp + 28]
    je .EL
    lea edx, [esp + 16]
    mov dword[esp], edx
    mov dword[esp + 4], 1
    mov dword[esp + 8], 1
    mov edx, dword[ebp + 8]
    mov dword[esp + 12], edx
    call fread
    
    mov dl, byte[esp + 16]
    mov byte[esi + edi], dl
    
    inc edi
    jmp .L
    
.EL:    
    mov eax, esi
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    ret