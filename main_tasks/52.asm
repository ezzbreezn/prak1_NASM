%include "io.inc"

section .rodata
    msg db `%d`, 0
    msgo db `%d `, 0
    
    
CEXTERN scanf
CEXTERN printf
CEXTERN malloc

section .bss
    n resd 1
    l resd 1
    r resd 1
    s resd 1

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
    
    mov dword[esp], msg
    mov dword[esp +4], n
    call scanf
    

    
    mov edx, dword[n]
    mov dword[esp], edx
    call malloc
    
    mov dword[l], eax
    
    mov edx, dword[n]
    mov dword[esp], edx
    call malloc
    
    mov dword[r], eax
    
    mov edx, dword[n]
    sal edx, 1
    mov dword[esp], edx
    call malloc
    
    
    mov dword[s], eax
    
    xor edi, edi
    mov esi, dword[l]
.l1:
    cmp edi, dword[n]
    je .el1
    mov dword[esp], msg
    lea edx, [esi + edi]
    mov dword[esp + 4], edx
    call scanf
    inc edi
    jmp .l1
.el1:    

    xor edi, edi
    mov esi, dword[r]
.l2:
    cmp edi, dword[n]
    je .el2
    mov dword[esp], msg
    lea edx, [esi + edi]
    mov dword[esp + 4], edx
    call scanf
    inc edi
    jmp .l2
.el2:   

    mov edx, dword[n]
    mov dword[esp], edx
    mov edx, dword[s]
    mov dword[esp + 4], edx
    mov edx, dword[l]
    mov dword[esp + 8], edx
    mov edx, dword[r]
    mov dword[esp + 12], edx
    call F
   
    mov esi, dword[s]
    xor edi, edi
    mov ebx, dword[n]
    sal ebx, 1
.l3:
    cmp edi, ebx
    je .el3
    mov dword[esp], msgo
    movsx edx, byte[esi + edi]
    mov dword[esp + 4], edx
    call printf
    inc edi
    jmp .l3
.el3:   
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
    mov ebx, ecx
.l:
    cmp ecx, dword[ebp + 8]
    je .el   
    mov al, byte[esi + ecx]

    mov byte[edi + ebx], al
    inc ebx
    mov al, byte[edx + ecx]
    mov byte[edi + ebx], al
    inc ebx
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