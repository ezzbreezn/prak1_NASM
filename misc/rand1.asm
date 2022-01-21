%include "io.inc"

section .rodata
    msg db `%s`, 0
    msgc db `%c` ,0
    msgd db `%d`, 0
    
    
CEXTERN scanf
CEXTERN printf
CEXTERN strlen


section .bss
    s resb 1000
    n resd 1
    c1 resb 1
    c2 resb 1

section .text
global CMAIN
CMAIN:
    ;write your code here
    push ebp
    mov ebp, esp
    sub esp,24
    
    mov dword[esp], msg
    mov dword[esp + 4], s
    call scanf
    
    mov dword[esp], s
    call strlen
    
    mov dword[n], eax
    
    mov dword[esp], msgc
    mov dword[esp + 4], c1
    call scanf
    
    mov dword[esp + 4], c2
    call scanf
    
    mov dword[esp], s
    mov ecx, dword[n]
    mov dword[esp + 4], ecx
    mov cl, 'i'
    movsx ecx, cl
    ;movsx ecx, byte[c1]
    mov dword[esp + 8], ecx
    mov cl, 'u'
    movsx ecx, cl
    ;movsx ecx, byte[c2]
    mov dword[esp + 12], ecx
    call replace
    
    test eax, eax
    jne .next
    mov dword[esp],  msgd
    mov dword[esp + 4], eax
    call printf
    jmp .out
.next:
    movsx eax, byte[eax]
    mov dword[esp], msgc
    mov dword[esp + 4], eax
    call printf
    
    
.out:    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
    
    
replace:
    push ebp
    mov ebp, esp
    push edi
    push esi
    mov edi, dword[ebp + 8]
    xor esi, esi
    xor ecx, ecx
.L: 
    cmp ecx, dword[ebp + 12]
    je .EL
    mov dl, byte[ebp + 16]
    cmp byte[edi + ecx], dl
    jne .skip
    test esi, esi
    jne .n1
    lea edx, [edi + ecx]
    mov esi, edx
.n1:
    mov dl, byte[ebp + 20]
    mov byte[edi + ecx], dl
    
 .skip:
    inc ecx
    jmp .L
.EL:   
    mov eax, esi
  
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    ret