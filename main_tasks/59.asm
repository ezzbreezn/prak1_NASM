%include "io.inc"

section .rodata
    msgf db `%lf` ,0
    msgc db `%c`, 0
    
CEXTERN scanf
CEXTERN printf
CEXTERN malloc
CEXTERN free 

section .bss
    root resd 1
    n resd 1
    temp resd 1
    d resd 2
    c resb 1
    fc resb 1
    prev resd 1

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
    
    xor edi, edi
.L:
    mov dword[esp], msgc
    mov dword[esp + 4], c
    call scanf
    
    cmp byte[c], '#'
    je .EL


    mov dword[esp], 24
    call malloc
    
    cmp edi, 0
    jne .skip
    mov dword[root], eax
.skip:
    mov cl, byte[c]
    mov byte[eax], cl
    mov esi, eax
    mov dword[esp], msgf
    mov dword[esp + 4], d
    mov edx, dword[d]
    mov dword[esi + 8], edx
    mov edx, dword[d + 4]
    mov dword[esi + 12], edx
    call scanf
    cmp edi, 0
    je .skip1
    mov ecx, dword[prev]
    mov dword[ecx + 16], esi
.skip1:    
    mov dword[prev], esi
    inc edi
    
    jmp .L
.EL:    
    mov dword[n], edi
    mov edx, dword[root]
    mov dword[esp], edx
    call F
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
    
F:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    finit
    
    mov edi, dword[ebp + 8]
    xor esi, esi
.L:
    
    cmp edi, 0
    je .EL
    fld qword[edi + 8]
    cmp esi, 0
    je .skip
    fucomi
    jae .rw
    fstp st0
    jmp .skip
.rw:
    finit
    fld qword[edi + 8]    
.skip:        
    inc esi
    mov edi, dword[edi + 16]
    jmp .L        
    
.EL:    
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    ret