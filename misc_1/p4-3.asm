%include "io.inc"

section .rodata
    msg db `%s`, 0
    b1 db `[`,0
    b2 db `]`,0
    cst db `%c`,0
    
section .bss
    s1 resb  101
    s2 resb 101
    l1 resd 1
    l2 resd 2
    p resd 1
    tp resd 1
    
CEXTERN scanf
CEXTERN printf
CEXTERN strstr 
CEXTERN strlen           

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msg
    mov dword[esp + 4], s1
    call scanf
    
    mov dword[esp], msg
    mov dword[esp + 4], s2
    call scanf
    
    
    mov dword[esp], s1
    call strlen
    mov dword[l1], eax
    
    mov dword[esp], s2
    call strlen
    mov dword[l2], eax
    
    mov dword[esp], s1
    mov dword[esp + 4], s2
    call strstr
    
    test eax, eax
    je .next
    
    mov dword[p], eax
    mov dword[tp], s1
.L1:
    mov edx, dword[tp]
    mov dl, byte[edx]
    test dl, dl
    je .EL1
    mov edx, dword[tp]
    cmp edx, dword[p]
    jne .nb1
    mov dword[esp], b1
    call printf
    jmp .ni
.nb1:
    mov ecx, dword[p]
    add ecx, dword[l2]
    cmp dword[tp], ecx
    jne .nb2
    mov dword[esp], b2
    call printf
    jmp .ni 
    
.nb2:                          
    
.ni:   

    mov ecx, dword[tp]
    mov cl, byte[ecx]
    mov dword[esp], cst
    mov byte[esp + 4], cl
    call printf
    
    inc dword[tp]
    jmp .L1    
.EL1:
    mov ecx, dword[p]
    add ecx, dword[l2]
    cmp dword[tp], ecx
    jne .out
    mov dword[esp], b2
    call printf
    jmp .out    
    
.next:   
    mov dword[esp], s2
    mov dword[esp + 4], s1
    call strstr
    test eax, eax
    je .nnext
    
    mov dword[p], eax
    mov dword[tp], s2
.L2:
    mov edx, dword[tp]
    mov dl, byte[edx]
    test dl, dl
    je .EL2
    mov edx, dword[tp]
    cmp edx, dword[p]
    jne .nbb1
    mov dword[esp], b1
    call printf
    jmp .nbi
.nbb1:
    mov ecx, dword[p]
    add ecx, dword[l1]
    cmp dword[tp], ecx
    jne .nbb2
    mov dword[esp], b2
    call printf
    jmp .nbi 
    
.nbb2:                          
    
.nbi:   

    mov ecx, dword[tp]
    mov cl, byte[ecx]
    mov dword[esp], cst
    mov byte[esp + 4], cl
    call printf
    
    inc dword[tp]
    jmp .L2    
.EL2:
    mov ecx, dword[p]
    add ecx, dword[l1]
    cmp dword[tp], ecx
    jne .out
    mov dword[esp], b2
    call printf

    jmp .out    
    
    
    
    
.nnext: 

   
      
    mov dword[tp], s1
.L3:
    mov edx, dword[tp]
    mov dl, byte[edx]
    test dl, dl
    je .EL3


    mov ecx, dword[tp]
    mov cl, byte[ecx]
    mov dword[esp], cst
    mov byte[esp + 4], cl
    call printf
    
    inc dword[tp]
    jmp .L3    
.EL3:   

.out:    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret