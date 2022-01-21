%include "io.inc"

section .rodata
    msg db `%c`, 0
    msgp db `YES`, 0
    msgn db `NO`, 0


CEXTERN scanf
CEXTERN printf
CEXTERN qsort

section .bss
    s resb 21
    x resb 1
    len resd 1

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
    mov dword[len], edi
    
    mov dword[esp], s
    mov ecx, dword[len]
    mov dword[esp + 4], ecx
    mov dword[esp + 8], 1
    mov dword[esp + 12], F
    call qsort
    
    mov ecx, 1
.L1:
    cmp ecx, dword[len]
    je .EL1
    mov al, byte[s + ecx - 1]
    mov dl, byte[s + ecx]
    cmp al, dl
    je .neg
    inc ecx
    jmp .L1
        
.EL1:
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
    
    
    
F:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov eax, dword[ebp + 8]
    mov edx, dword[ebp + 12]
    mov al, byte[eax]
    mov dl, byte[edx]
    cmp al, dl
    jg .g
    je .e
    mov eax, -1
    jmp .out
.g:
    mov eax, 1
    jmp .out
.e:
    xor eax, eax        
.out:    
    mov esp, ebp
    pop ebp
    ret
        
            
                    