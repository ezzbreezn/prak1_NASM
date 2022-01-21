%include "io.inc"

section .bss
    n resd 1
    k resd 1
    sum resd 1
    ans resd 1
    prev resd 1

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, [n]
    GET_UDEC 4, [k]
    mov ecx, dword[n]
    add dword[ans], ecx
.L:
    push dword[k]
    push dword[n]
    call F
    add esp, 8
    add dword[ans], eax    
    cmp dword[n], eax
    je .EL
   
    mov dword[n], eax
    jmp .L
    
.EL:   
    PRINT_UDEC 4, [ans]
    xor eax, eax
    ret
    
F:
    push ebp
    mov ebp, esp
    push edi
    xor ecx, ecx
    mov eax, dword[ebp + 8]
.L:
    test eax, eax
    je .EL
    xor edx, edx
    div dword[ebp + 12]
    add ecx, edx
    jmp .L
   
.EL:    
    mov eax, ecx
    jmp .EL2
    ;xor ecx, ecx
;.L2:
 ;   test eax, eax
 ;   je .EL2    
 ;   mov edi, eax
 ;   mov eax, ecx
 ;   mul dword[ebp + 12]
 ;   mov ecx, eax
 ;   mov eax, edi
 ;   xor edx, edx
 ;   div dword[ebp + 12]
 ;   add ecx, edx
 ;   jmp .L2
.EL2:
    mov eax, ecx    
    mov esp, ebp
    sub esp, 4
    pop edi
    pop ebp
    ret         