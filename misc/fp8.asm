%include "io.inc"

section .rodata
    msgi db `%d`, 0
    msgf db `%lf`, 0
    
section .bss
    n resd 1
    v resd 1
    u resd 1    
    
    
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
    push ebx
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msgi
    mov dword[esp + 4], n
    call scanf
    
    mov edx, dword[n]
    sal edx, 3
    mov dword[esp], edx
    call malloc
    mov dword[v], eax
    
    mov edx, dword[n]
    sal edx, 3
    mov dword[esp], edx
    call malloc
    mov dword[u], eax
    
    mov edi, dword[v]
    xor esi, esi
.L1:
    cmp esi, dword[n]
    je .EL1
    mov dword[esp], msgf
    lea edx, [edi + 8 * esi]
    mov dword[esp + 4], edx
    call scanf
    inc esi
    jmp .L1
.EL1:

    mov edi, dword[u]
    xor esi, esi
    
.L2:
    cmp esi, dword[n]
    je .EL2
    mov dword[esp], msgf
    lea edx, [edi + 8 * esi]
    mov dword[esp + 4], edx
    call scanf
    inc esi
    jmp .L2
.EL2:
    
    mov edx, dword[n]
    mov dword[esp], edx
    mov edx, dword[v]
    mov dword[esp + 4], edx
    mov edx, dword[u]
    mov dword[esp + 8], edx
    call SCP
    
    fstp qword[esp + 4]
    mov dword[esp], msgf
    call printf
    
    mov esp, ebp
    sub esp, 12
    pop ebx
    pop esi
    pop edi
    pop ebp
    xor eax, eax
    ret
    
SCP:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov eax, dword[ebp + 12]
    mov ecx, dword[ebp + 16]
    xor ecx, ecx
    finit
.L:
    cmp ecx, dword[ebp + 8]
    je .EL
    
    fld qword[eax + 8 * ecx]
    fld qword[edx + 8 * ecx]
    fmulp
    test ecx, ecx
    je .skip
    faddp
.skip:
    inc ecx
    jmp .L
.EL:
        
            
    mov esp, ebp
    pop ebp
    ret    