%include "io.inc"

section .rodata
.START:
    dd .L0
    dd .L1
    dd .L2
    dd .L3
    
section .rodata
    msgc db `%c`, 0
    msgs db `%hi` ,0
    msgd db `%d`, 0

section .bss
    a resd 1
    n resd 1    
    
CEXTERN scanf
CEXTERN printf
CEXTERN malloc
CEXTERN free

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msgd
    mov dword[esp + 4], n
    call scanf
    
    mov eax, dword[n]
    mov ecx, 6
    xor edx, edx
    mul ecx
    mov dword[esp], eax
    call malloc
    
    mov dword[a], eax
    
    xor edi, edi
    mov esi, dword[a]
.L:
    cmp edi, dword[n]
    je .EL
    
    mov dword[esp], msgd
    lea ecx, [edi + 2 * edi]
    sal ecx, 1
    lea edx, [esi + ecx]
    mov dword[esp + 4], edx
    call scanf
    
    lea ecx, [edi + 2 * edi]
    sal ecx, 1
    lea edx, [esi + ecx + 1]
    mov dword[esp + 4], edx
    call scanf
    
    lea ecx, [edi + 2 * edi]
    sal ecx, 1
    lea edx, [esi + ecx + 2]
    mov dword[esp + 4], edx
    call scanf
    
    lea ecx, [edi + 2 * edi]
    sal ecx, 1
    lea edx, [esi + ecx + 4]
    mov dword[esp + 4], edx
    mov dword[esp], msgs
    call scanf
    
    inc edi
    jmp .L
.EL:
    mov edx, dword[a]
    mov dword[esp], edx
    call SUM
    mov dword[esp + 4], eax
    mov dword[esp], msgd
    call printf
    
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    xor eax, eax
    ret
    
    
SUM:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    mov dword[esp + 12], 0
    mov esi, dword[ebp + 8]
    xor edi, edi
.L:
    lea edx, [edi + 2 * edi]
    sal edx, 1
    mov cl, byte[esi + edx + 1]
    sal cl, 1
    mov al, byte[esi + edx]
    add cl, al
    dec cl
    movzx ecx, cl
    jmp [.START + 4 * ecx]
.L0:
    movzx eax, byte[esi + edx + 4]
    add dword[esp + 12], eax
    jmp .out
.L1:
    movzx eax, word[esi + edx + 4]
    add dword[esp + 12], eax
    jmp .out
.L2:
    movsx eax, byte[esi + edx + 4]
    add dword[esp + 12], eax
    jmp .out
.L3:
    
    movsx eax, word[esi + edx + 4]
    add dword[esp + 12], eax
.out:
    inc edi
    cmp byte[esi + edx + 2], 0
    jne .EL
    jmp .L
    
.EL:    
    mov eax, dword[esp + 12]
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    ret