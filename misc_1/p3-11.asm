%include "io.inc"

section .bss
    n resd 1
    x resd 1

section .text
global CMAIN
CMAIN:
    GET_DEC 4, [n]
    xor edi, edi
.L:
    cmp edi, dword[n]
    je .EL
    GET_UDEC 4, [x]
    push dword[x]
    call F
    add esp, 4
    test eax, eax
    je .n
    PRINT_STRING `YES\n`
    jmp .ni
.n:
    PRINT_STRING `NO\n`
.ni:
    inc edi
    jmp .L            
.EL:    
    xor eax, eax
    ret
    
F:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    mov eax, 1
    xor ebx, ebx
    xor edx, edx
    xor ecx, ecx
.L:
    ;cmp eax, dword[ebp + 8]
    cmp ecx, 32
    jg .EL
    test ecx, 1
    je .ev
    test eax, dword[ebp + 8]
    je .s1
    inc ebx
    jmp .s1
.ev:
    test eax, dword[ebp + 8]
    je .s1
    inc edx
    
.s1:  
    inc ecx
    shl eax, 1
    jmp .L      
        
   
.EL:
    xor esi, esi

    cmp edx, ebx
    jne .c1
    mov esi, 1
    jmp .out
.c1:
    jg .x
    xchg edx, ebx
.x:
    sub edx, ebx
    cmp edx, 3
    jl .out
    push edx
    call F
    add esp, 4
    test eax, eax
    je .out
    mov esi, eax
    ;mov eax, edx
    ;xor edx, edx
    ;mov ebx, 3
    ;div ebx
    ;test edx, edx
    ;jne .out
    ;mov ecx, 1        
.out:    
    mov eax, esi
    mov esp, ebp
    sub esp, 8
    pop esi
    pop ebx
    pop ebp
    ret    