%include "io.inc"

section .text
global CMAIN
CMAIN:
    ;write your code here
    xor eax, eax
    ret
  global count  
count:
    push ebp
    mov ebp, esp
    push edi
    push esi
    push ebx
    and esp, ~15
    sub esp, 16
    
    mov esi, dword[ebp + 12]
    xor edi, edi
    xor eax, eax
.l:
    cmp edi, dword[ebp + 8  ]
    je .el  
    mov edx, edi
    lea edx, [edx + 4 * edx]
    cmp dword[esi + 4 * edx], 0
    jne .n
    add eax, dword[esi + 4 * edx]
    jmp .ni
.n:
    mov cl, byte[esi + 4 * edx + 4]
    mov dword[esp], edi
    lea edi, [esi + 4 * edx + 5]
    xor ebx, ebx
.l2:
    cmp ebx, 13
    je .el2
    cmp byte[edi + ebx], cl 
    jne .nni
    inc eax
.nni:    
    inc ebx
    jmp .l2
.el2:
    mov edi, dword[esp]
.ni:
    inc edi
    jmp .l    
        
.el:    
            
    mov esp, ebp
    sub esp, 12
    pop ebx
    pop esi
    pop edi
    pop ebp
    ret    