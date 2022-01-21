%include "io.inc"

section .rodata
    msg db `%d`, 0
    
CEXTERN scanf
CEXTERN printf
CEXTERN malloc
CEXTERN free

section .bss
    root resd 1
    n resd 1
    k resd 1
    p resd 1

section .text
global CMAIN
CMAIN:
    ;write your code here
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msg
    mov dword[esp + 4], n
    call scanf
    
    xor edi, edi
.L:
    cmp edi, dword[n]
    je .EL
    
    mov dword[esp], 8
    call malloc
    
    cmp edi, 0
    jne .n
    mov dword[root], eax
    
.n:
    mov esi, eax
    
    mov dword[esp], msg
    lea edx, [eax]
    mov dword[esp + 4], edx
    call scanf
    
    cmp dword[p], 0
    je .ni
    mov edx, dword[p]
    mov dword[edx + 4], esi
.ni:
    mov dword[p], esi
    inc edi
    jmp .L  
    
   
.EL:
    mov dword[esp], msg
    mov dword[esp + 4], k
    call scanf
    
    mov edx, dword[root]
    mov dword[esp], edx
    mov edx, dword[k]
    mov dword[esp + 4], edx
    call F
    sub esp, 8
    mov dword[esp], msg
    mov dword[esp + 4], eax
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
    and esp, ~16
    sub esp, 16
    
    xor eax,eax
    mov edi, dword[ebp + 8]
.L:
    cmp edi, 0
    je .EL
    
    mov ecx, dword[edi]
    cmp ecx, dword[ebp + 12]
    jne .skip
    inc eax
.skip:
    mov edi, dword[edi + 4]
    jmp .L
              
.EL:    
    mov esp, ebp
    sub esp, 8
    pop esi
    pop esi
    pop ebp
    ret 8