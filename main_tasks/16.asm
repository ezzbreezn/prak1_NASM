%include "io.inc"

section .rodata
    msg db `%hi`, 0
    msgo db `%hi `, 0
    
section .bss
    n resw 1
    len resw 1
    a resw 1000
    ans resw 1

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
    mov dword[esp + 4], len
    call scanf
    
    xor edi, edi
.L:
    cmp di, word[len]
    je .EL
    mov dword[esp], msg
    lea edx, [a + 2 * edi]
    mov dword[esp + 4], edx
    call scanf
    inc edi
    jmp .L
    
.EL:
    movsx ecx, word[len]
    mov dword[esp + 4], ecx
    mov dword[esp + 8], a
    call F
    mov dword[ans], eax
    
    mov dword[esp], msgo
    movsx ecx, word[ans]
    mov dword[esp + 4], ecx
    call printf
    
    movsx ecx, word[ans + 2]
    mov dword[esp + 4], ecx
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
    sub esp, 16
    
    mov dword[esp + 12], 0
    mov dword[esp + 8], 0
    xor ecx, ecx
    mov edi, dword[ebp + 16]
.L:
    cmp cx, word[ebp + 12]
    je .EL
    mov dx, word[edi + 2 * ecx]
    cmp word[esp + 12], dx
    jne .else
    cmp word[esp + 8], 0
    je .else
    inc word[esp + 8]
    jmp .ni
.else:
    mov dx, word[edi + 2 * ecx]
    cmp word[esp + 12], dx
    jg .check
    cmp word[esp + 8], 0
    jne .ni
.check:
    mov word[esp + 12], dx
    mov word[esp + 8], 1
    
    
    
.ni:
    inc ecx
    jmp .L    
.EL:    
    mov dx, word[esp + 8]
    mov ax, dx
    sal eax, 16
    mov dx, word[esp + 12]
    mov ax, dx
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    ret