%include "io.inc"

section .rodata
    msgc db `%c`, 0
    msgf db `%lf`, 0
    msgi db `%d`, 0


CEXTERN scanf
CEXTERN printf
CEXTERN malloc

section .bss
    a resd 1
    n resd 1

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msgi
    mov dword[esp + 4], n
    call scanf
    
    mov dword[esp], 20
    call malloc
    
    mov dword[a], eax
    mov edi, dword[a]
    xor esi, esi
.L:
    cmp esi, dword[n]
    je .EL
    
    mov dword[esp], msgc
    mov dword[esp + 4], edi
    call scanf
    
    mov dword[esp], msgf
    lea edx, [edi + 8]
    mov dword[esp + 4], edx
    call scanf
    
    inc esi
    cmp esi, dword[n]
    je .EL
    
    mov dword[esp], 20
    call malloc
    
    mov dword[edi + 16], eax
    
    mov edi, dword[edi + 16]
    jmp .L
    
.EL:    
    finit
    push dword[a]
    call F
    
    fstp qword[esp + 4]
    mov dword[esp], msgf
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
    mov edx, dword[ebp + 8]
    mov ecx, dword[edx + 16]
    test ecx, ecx
    jne .next
    fld qword[edx + 8]   
    mov esp, ebp
    pop ebp
    ret 4
.next:
    push dword[edx + 16]
    call F
    mov edx, dword[ebp + 8]
    fld qword[edx + 8]
    fucomi st0, st1
    jbe .skip
    finit
    fld qword[edx + 8]
    jmp .out
.skip:
    fstp st0
.out:
    mov esp, ebp
    pop ebp
    ret 4   