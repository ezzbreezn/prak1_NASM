%include "io.inc"

section .rodata
    msg db `%d`, 0
    msgo db `%d `, 0
    
CEXTERN scanf
CEXTERN printf
CEXTERN malloc
CEXTERN free


section .bss
    list resd 1  
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
    
    mov dword[esp], 8
    call malloc
    
    mov dword[list], eax
    
    mov edi, dword[list]
    
    mov dword[esp], msg
    mov dword[esp + 4], n
    call scanf
    
    xor esi, esi
.L:
    cmp esi, dword[n]
    je .EL
    mov dword[esp], msg
    mov dword[esp + 4], edi
    call scanf
    
    inc esi
    cmp esi, dword[n]
    je .EL
    
    mov dword[esp], 8
    call malloc
    
    mov dword[edi + 4], eax
    mov edi, dword[edi + 4]
    jmp .L
       
.EL:                
    
    mov edi, dword[list]
    
.L1:
    test edi, edi
    je .EL1
    mov edx, dword[edi]
    mov dword[esp], msgo
    mov dword[esp + 4], edx
    call printf
            
    mov edi, dword[edi + 4]
    jmp .L1
   
    
                
.EL1:   
    push dword[list]
    call F
    add esp, 4
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
    xor eax, eax
    mov edx, dword[ebp + 8]
.L:
    test edx, edx
    je .EL
    movsx ecx, word[edx]
    add eax, ecx
    mov edx, dword[edx + 4]
    jmp .L    
.EL:            
    mov esp, ebp
    pop ebp
    ret    