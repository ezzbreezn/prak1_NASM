%include "io.inc"

section .bss
    n resd 1
    c resd 1
    z resd 1
    tmp resd 1
    t1 resd 1
    t2 resd 1
    ct resd 1

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, [n]
    mov dword[ct], 0
L:
    mov ecx, dword[ct]
    cmp ecx, dword[n]
    jge EL
    GET_UDEC 4, esi
    GET_UDEC 4, ebx
    inc dword[ct]
    cmp dword[z], 0
    jne .next
    mov dword[c], esi
    mov dword[z], ebx
    jmp L
  .next:
    mov edi, dword[z]
    push edi
    push ebx
    call LCM
    add esp, 8
    mov dword[tmp], eax
    xor edx, edx
    div dword[z]
    mov dword[t1], eax
    mov eax, dword[c]
    xor edx, edx
    mul dword[t1]
    mov dword[c], eax
    mov eax, dword[tmp]
    mov dword[z], eax
    xor edx, edx
    div ebx
    mov dword[t2], eax
    mov eax, esi
    xor edx, edx
    mul dword[t2]
    add dword[c], eax
  .P:
    mov esi, dword[c]
    mov ebx, dword[z]
    push esi
    push ebx
    call GCD
    add esp, 8
    cmp eax, 1
    je .EP
    mov dword[tmp], eax
    mov eax, dword[c]
    xor edx, edx
    div dword[tmp]
    mov dword[c], eax
    mov eax, dword[z]
    xor edx, edx
    div dword[tmp]
    mov dword[z], eax
    jmp .P
  .EP:
    jmp L
EL:
    PRINT_DEC 4, [c]
    PRINT_CHAR " "
    PRINT_DEC 4, [z]
    NEWLINE
    xor eax, eax
    ret
    
GCD:
    push ebp
    mov ebp, esp

    push edi
    mov edi, dword[ebp + 8]
    mov ecx, dword[ebp + 12]
    cmp edi, ecx
    jae .C
    xchg edi, ecx
    
  .C:
    test ecx, ecx
    je .out
    mov eax, edi
    xor edx, edx
    div ecx
    mov edi, edx
    xchg edi, ecx
    jmp .C
  .out:
    mov eax, edi
    pop edi
    mov esp, ebp
    pop ebp
    
    ret 
LCM:
    push ebp
    mov ebp, esp
    push edi
    mov ecx, dword[ebp + 8]
    mov edx, dword[ebp + 12]
    push edx
    push ecx
    call GCD
    add esp, 8
    mov edi, eax
    mov eax, dword[ebp + 8]
    xor edx, edx
    div edi
    mul dword[ebp + 12]
    

    pop edi
    mov esp, ebp
    pop ebp
    ret
      