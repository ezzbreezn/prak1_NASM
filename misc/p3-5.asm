%include "io.inc"

section .bss
    m resd 1
    n resd 1

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, [m]
    GET_UDEC 4, [n]
    xor edi, edi
.L:
    cmp edi, dword[n]
    je .end
    ;PRINT_UDEC 4, [m]
    ;NEWLINE
    
    push dword[m]
    call REVERSE
   ; PRINT_UDEC 4, eax
   ; NEWLINE
   ; NEWLINE
    add esp, 4
    ;cmp dword[m], eax
    ;jne .next
    ;PRINT_STRING "No"
    ;jmp .out
;.next:    
    add dword[m], eax
    inc edi
    jmp .L
.end:
    push dword[m]
    call REVERSE
    add esp, 4
    cmp dword[m], eax
    je .POS
    PRINT_STRING "No"
    jmp .out
.POS:
    PRINT_STRING "Yes"
    NEWLINE
    PRINT_UDEC 4, [m]
.out:            
    xor eax, eax
    ret
    
REVERSE:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    xor ebx, ebx
    mov eax, dword[ebp + 8]
    mov ecx, 10
    
.L:
    test eax, eax
    je .EL
    mov esi, eax
    mov eax, ebx
    mul ecx
    mov ebx, eax
    mov eax, esi
    xor edx, edx
    div ecx
    add ebx, edx
    jmp .L
.EL:        
    
    mov eax, ebx    
    mov esp, ebp
    sub esp, 8
    pop esi
    pop ebx
    pop ebp
    ret            