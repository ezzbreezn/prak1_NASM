%include "io.inc"

section .bss
    k resd 1
    n resd 1
    a resd 1
    t1 resd 1
    t2 resd 1
    res resd 1
    temp resd 1

section .data
    mod dd 2011

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, [k]
    GET_UDEC 4, [n]
    GET_UDEC 4, [a]
    mov ecx, dword[n]
    push ecx
    call PROC
    add esp, 4
    PRINT_UDEC 4, eax
    xor eax, eax
    ret
    
PROC:
    push ebp
    mov ebp, esp
    ;push edi
    mov ecx, dword[ebp + 8]
    test ecx, ecx
    jne .next1
    mov eax, dword[a]
    xor edx, edx
    div dword[mod]
    mov eax, edx
    jmp .end
  .next1:
    cmp ecx, 1
    jne .next2
    dec ecx
    push ecx
    call PROC
    add esp, 4
    mov dword[t1], eax
    mov dword[t2], eax
    mov eax, dword[t2]
  .L2:
    test eax, eax
    je .EL2
    xor edx, edx
    div dword[k]
    push edx
    jmp .L2
    
  .EL2:
    mov eax, dword[t1]
  .L1:
    test eax, eax
    je .EL1
    xor edx, edx
    div dword[k]
    push edx
    jmp .L1
    
  .EL1:
    
  .REC:
    cmp esp, ebp
    je .ENDREC
    mov eax, dword[res]
    xor edx, edx
    mul dword[k]
    pop edx
    add eax, edx
    mov dword[res], eax
    jmp .REC
    
  .ENDREC:
    mov eax, dword[res]
    xor edx, edx
    div dword[mod]
    mov eax, edx
    jmp .end
    
  .next2:
    sub esp, 8
    ;sub esp, 12
    mov eax, dword[ebp + 8]
    dec eax
    mov dword[esp], eax
    ;dec ecx
    ;push ecx
    call PROC
    ;PRINT_DEC 4, eax
    ;NEWLINE
    mov dword[ebp - 4], eax
    mov eax, dword[ebp + 8]
    sub eax, 2
    mov dword[esp], eax
    ;add esp, 4
    ;mov dword[t1], eax
    ;dec ecx
    ;push ecx
    call PROC
    ;PRINT_DEC 4, eax
    ;NEWLINE
    mov dword[ebp - 8], eax
    ;dd esp, 4
    ;mov dword[t2], eax

    xor ecx, ecx
    mov eax, dword[ebp - 8]
  .LL2:
    test eax, eax
    je .ELL2
    xor edx, edx
    div dword[k]
    push edx
    inc ecx
    jmp .LL2
    
  .ELL2:
    mov eax, dword[ebp - 4]
  .LL1:
    test eax, eax
    je .ELL1
    xor edx, edx
    div dword[k]
    push edx
    inc ecx
    jmp .LL1
    
  .ELL1:
    ;mov ecx, dword[ebp - 8]
    ;mov dword[temp], ecx
    mov dword[res], 0
    
  .RECC:
    ;cmp esp, dword[ebp - 8]
    test ecx, ecx
    je .ENDRECC
    mov eax, dword[res]
    xor edx, edx
    mul dword[k]
    pop edx
    dec ecx
    add eax, edx
    mov dword[res], eax
    jmp .RECC
    
  .ENDRECC:
  
    mov eax, dword[res]
    xor edx, edx
    div dword[mod]
    mov eax, edx
    jmp .end
    
  .end:
    mov esp, ebp
    pop ebp
    ret