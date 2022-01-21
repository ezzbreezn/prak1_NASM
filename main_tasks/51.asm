%include "io.inc"

section .rodata
    msgc db `%d`, 0
    msgd db `%d`, 0
    msgdo db `%d `, 0
    nl db `\n`, 0
    
    
CEXTERN scanf
CEXTERN printf
CEXTERN malloc

section .bss
    n resd 1
    s resd 1
    l resd 1
    r resd 1

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
    
    mov dword[esp], msgc
    mov dword[esp + 4], n
    call scanf
    
    mov edx, dword[n]
    mov dword[esp], edx
    call malloc
    mov dword[s], eax
    
    mov edx, dword[n]
    shr edx,1 
    mov dword[esp], edx
    call malloc
    mov dword[l], eax
    
    mov edx, dword[n]
    shr edx, 1
    mov dword[esp], edx
    call malloc
    mov dword[r], eax
    
    
    
    mov esi, dword[s]
    xor edi, edi
.L:
    cmp edi, dword[n]
    je .EL
    mov dword[esp], msgc
    lea edx, [esi + edi]
    mov dword[esp + 4], edx
    call scanf
    inc edi
    jmp .L
.EL:
    mov edx,dword[n]
    mov dword[esp], edx
    mov esi, dword[s]
    mov dword[esp + 4], esi
    mov esi, dword[l]
    mov dword[esp + 8], esi
    mov esi, dword[r]
    mov dword[esp + 12],esi
    call F
    
    xor edi, edi
    mov esi, dword[l]
    mov ebx, dword[n]
    shr ebx, 1
.l:
    cmp edi, ebx
    je .el
    movsx edx, byte[esi + edi]
    mov dword[esp + 4], edx
    mov dword[esp], msgdo
    call printf
    inc edi
    jmp .l
    
.el:    
    mov dword[esp], nl
    call printf
    
    xor edi, edi
    mov esi, dword[r]
.l1:
    cmp edi, ebx
    je .el1
    movsx edx, byte[esi + edi]
    mov dword[esp + 4], edx
    mov dword[esp], msgdo
    call printf
    inc edi
    jmp .l1      
            
.el1:              
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
    push ebx
    and esp, ~15
    sub esp, 16
    
    mov edi, dword[ebp + 12]
    mov esi, dword[ebp + 16]
    mov edx, dword[ebp + 20]
    xor ecx, ecx
.l:
    cmp ecx, dword[ebp +8]
    je .el
    mov ebx, ecx
    shr ebx, 1 
    mov al, byte[edi + ecx]
    mov byte[esi + ebx], al
    inc ecx
    mov al, byte[edi + ecx]
    mov byte[edx + ebx], al
    inc ecx
    jmp .l
.el:
    mov esp, ebp
    sub esp, 12
    pop ebx
    pop esi
    pop edi
    pop ebp
    ret