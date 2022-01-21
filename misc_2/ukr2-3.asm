%include "io.inc"

section .rodata
    msg db `%c`, 0
    msgp db `YES`, 0
    msgn db `NO`, 0

section .bss
    s resb 21
    x resb 1
    len resd 1

CEXTERN scanf
CEXTERN printf
CEXTERN qsort

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    xor edi, edi
.L:
    mov dword[esp], msg
    mov dword[esp + 4], x
    call scanf
    
    cmp byte[x], '.'
    je .EL
    mov cl, byte[x]
    mov byte[s + edi], cl
    inc edi
    jmp .L 
.EL:                 
    mov dword[esp], s
    mov edx, dword[len]
    mov dword[esp + 4], edi
    call CHECK
    
    test eax,eax
    je .neg
    mov dword[esp], msgp
    call printf
    jmp .out
.neg:    
    mov dword[esp], msgn
    call printf
   
    
.out:  
                
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
    
CHECK:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov eax, dword[ebp + 8]
    mov dword[esp], eax
    mov eax, dword[ebp + 12]
    mov dword[esp + 4], eax
    mov dword[esp + 8], 1
    mov dword[esp + 12], F
    call qsort
    
    mov edx, dword[ebp + 8]
    mov ecx, 1
.L:
    cmp ecx, dword[ebp + 12]
    je .EL
    mov al, byte[edx + ecx]
    cmp byte[edx + ecx -1], al
    je .pos
    inc ecx
    jmp .L
        
.EL:    
    xor eax, eax
    jmp .out    
.pos:    
    mov eax, 1 
.out:                   
    mov esp, ebp
    pop ebp
    ret    
    
    
F:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov eax, dword[ebp + 8]
    mov ecx, dword[ebp + 12]
    mov al, byte[eax]
    mov cl, byte[ecx]
    cmp al, cl
    jl .l
    je .e
    mov eax, 1
    jmp .out
.l:    
    mov eax, -1
    jmp .out 
.e:
    xor eax, eax    
.out:        
    
    mov esp, ebp
    pop ebp
    ret    