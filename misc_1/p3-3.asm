%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp
    GET_DEC 4, ecx
    push ecx
    call F
    add esp, 4
    xor eax, eax
    ret
F:
    push ebp
    mov ebp, esp
    mov eax, dword[ebp + 8]
    test eax, eax
    je .end
    GET_DEC 4, ecx
    push ecx
    call F
    mov eax, dword[ebp + 8]
    PRINT_DEC 4, eax
    PRINT_CHAR " "
  .end:
    mov esp, ebp
    pop ebp
    ret
    