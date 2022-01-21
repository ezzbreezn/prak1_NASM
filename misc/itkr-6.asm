%include "io.inc"

section .rodata
    msg db `%d`, 0
    msgo db `%d `, 0
    
    
CEXTERN scanf
CEXTERN printf

section .bss
    n resd 1
    a resd 10

section .data
    mod dd 10

section .text
global CMAIN
CMAIN:
    ;write your code here
    push ebp
    mov ebp, esp
    push edi
    push esi
    sub esp, 16
    
    mov dword[esp], msg
    mov dword[esp + 4], n
    call scanf
    
    mov eax, dword[n]
    cmp eax, 0
    jge .skip
    neg eax
.skip:    
    
.L: 
    test eax, eax
    je .EL
    xor edx, edx
    div dword[mod]
    inc dword[a + 4 * edx]
    jmp .L
        
.EL:   

    xor edi, edi
.L1:
    cmp edi, 10
    je .EL1
    cmp dword[a + 4 * edi], 1
    jne .s
    mov dword[esp], msgo
    mov dword[esp + 4], edi
    call printf 
           
.s:                         
    inc edi
    jmp .L1                                  
.EL1:                                                                                               
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    xor eax, eax
    ret