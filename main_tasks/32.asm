%include "io.inc"

section .rodata
    msg db `%d`, 0
    
    
CEXTERN scanf
CEXTERN printf
CEXTERN malloc
CEXTERN free

section .bss
    a resd 1
    b resd 1
    n1 resd 1
    n2 resd 1

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
    mov dword[esp + 4], n1
    call scanf
    
    mov edx, dword[n1]
    sal edx, 2
    mov dword[esp], edx
    call malloc
    mov dword[a], eax
    
    xor edi, edi
    mov esi, dword[a]
.L1:
    cmp edi,dword[n1]
    je .EL1
    mov dword[esp], msg
    lea edx, [esi + 4 * edi]
    mov dword[esp + 4], edx
    call scanf
    
    inc edi
    jmp .L1
.EL1:    
    mov dword[esp], msg
    mov dword[esp + 4], n2
    call scanf
    
    mov edx, dword[n2]
    sal edx, 2
    mov dword[esp], edx
    call malloc
    mov dword[b], eax
    
    xor edi, edi
    mov esi, dword[b]
.L2:
    cmp edi, dword[n2]
    je .EL2
    
    mov dword[esp], msg
    lea edx, [esi + 4 * edi]
    mov dword[esp + 4], edx
    call scanf
    
    inc edi
    jmp .L2
.EL2:

    mov edx, dword[a]
    mov dword[esp], edx
    mov edx, dword[b]
    mov dword[esp + 4], edx
    mov edx, dword[n1]
    mov dword[esp + 8], edx
    mov dword[esp + 12], F
    call FUNC
    
    
    mov esi, dword[b]
    xor edi, edi
.L3:
    cmp edi, dword[n2]
    je .EL3
    
    mov dword[esp], msg
    mov edx, dword[esi + 4 * edi]
    mov dword[esp + 4], edx
    call printf
    inc edi
    jmp .L3
    
.EL3:
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
    
    mov eax, dword[ebp + 8]
    add eax, 3
    
    mov esp, ebp
    pop ebp
    ret   
    
FUNC:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    mov edi, dword[ebp + 8]
    mov esi, dword[ebp + 12]
    
    xor ecx, ecx
.L:
    cmp ecx, dword[ebp + 16]
    je .EL
    
    mov edx, dword[edi + 4 * ecx]
    mov dword[esp], edx
    call dword[ebp + 20]
    
    mov dword[esi + 4 * ecx], eax
    inc ecx
    jmp .L
    
.EL:    
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    ret
     