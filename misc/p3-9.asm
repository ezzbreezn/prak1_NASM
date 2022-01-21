%include "io.inc"

section .bss
    k resd 1

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, [k]
    mov eax, dword[k]
    push eax
    call F
    add esp, 4
    xor eax, eax
    ret
    
F:
    push ebp
    mov ebp, esp
    push edi
    push esi
    push ebx
    mov ecx, dword[ebp + 8]
    mov edi, 1
    
  .L:
    mov esi, 1
    xor ebx, ebx
  .L1:
    cmp esi, edi
    je .out
    mov eax, edi
    xor edx, edx
    div esi
    test edx, edx
    jne .cnt
    add ebx, esi
  .cnt:
    inc esi
    jmp .L1
  .out:
    cmp ebx, edi
    jge .skip
    dec ecx
  .skip:
    test ecx, ecx
    je .ans
    inc edi
    jmp .L
    
  .ans:
    PRINT_UDEC 4, edi
    mov eax, edi
    
    
    
    
    
    pop ebx
    pop esi
    pop edi
    mov esp, ebp
    pop ebp
    ret
    