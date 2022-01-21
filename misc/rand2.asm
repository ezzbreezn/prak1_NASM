%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ecx, 32767
    call worstLoadTime
    PRINT_DEC 4, eax
    xor eax, eax
    ret
    
    
worstLoadTime:
    sub esp, 12
    mov eax, 6010
    movzx ecx, cx
    mul ecx
    add esp, 12
    ret
    
      
        
flip:
    sub esp, 12
    cmp dword[ecx + 32], 0
    jne .next
    mov eax, ecx
    jmp .out
.next:
    mov dword[esp + 8], ecx
    mov ecx, dword[ecx + 32]
    call flip
    mov dword[esp + 4], eax
    mov ecx, dword[esp + 8]
    mov ecx, dword[ecx + 32]
    mov eax, dword[esp + 8]
    mov dword[ecx + 32], eax
    mov ecx, dword[esp + 8]
    mov dword[ecx + 32], 0
    mov eax, dword[esp + 4]                               
.out:
    add esp, 12
    ret         
    
section .bss
    a resd 1
    b resd 1
    c resd 1
    
       
section .text
    mov ecx, dword[a]
    cmp ecx, dword[b]
    jne .next
    mov eax, dword[a]
    jmp .out
.next:
    mov ecx, dword[c]
    mov ecx, dword[ecx]
    add dword[c], 4
    mov eax, dword[b]
    add eax, ecx
.out:   
             
    ;mov ecx, dword[s + 16]
    ;mov dword[d], ecx
    ;mov ecx, dword[s + 20]
    ;mov dword[d + 4], ecx
    
    ;mov ecx, dword[p]
    ;mov dword[ecx], 0
    
    
    