%include "io.inc"

section .rodata
    msg db `%d`, 0
    msgo db `%d `, 0
    
section .bss
    temp resd 1    
    
CEXTERN scanf
CEXTERN printf    

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
    mov dword[esp + 4], temp
    call scanf
    
    
  

    mov edi, dword[temp]
    sal edi, 2
    add edi, 15
    shr edi, 4
    sal edi, 4
    sub esp, edi
    sub esp, 16
    xor edi, edi 
.L:
    cmp edi, dword[temp]
    je .EL
    mov dword[esp], msg
    lea edx, [esp + 4 * edi + 20]
    mov dword[esp + 4], edx
    call scanf
    inc edi
    jmp .L
    
.EL:    
    mov edx, dword[temp]
    mov dword[esp + 16], edx
    add esp, 16
    call F
    
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
    
    mov edi, dword[ebp + 8]
    xor esi, esi
    
.L:
    cmp esi, edi
    je .EL
    mov dword[esp], msgo
    mov edx, dword[ebp + 4 * esi + 12]
    mov dword[esp + 4], edx
    call printf
    
    inc esi
    jmp .L
   
.EL:
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    ret