%include "io.inc"

section .bss
    t resb 1
    mx resd 1
    tmp resd 1
section .data
    base db 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'    
section .text
global CMAIN
CMAIN:
    ;push t
    push 25
    push dword[tmp]
    call F
    add esp, 8
    PRINT_DEC 4, [mx]
    xor eax, eax
    ret
F:
    push ebp
    mov ebp, esp
    ;GET_CHAR [t]
    ;cmp byte[t], '.'
    GET_CHAR al
    cmp al, '.'
    je .out
    mov edx, dword[ebp + 12]
    mov dl, byte[base + edx]
    cmp al, dl
    jne .next
    
    mov edx, dword[ebp + 8]
    inc edx
    cmp edx, dword[mx]
    jle .n
    mov dword[mx], edx
    jmp .n
.n:
    mov edx, dword[ebp + 12]
    dec edx
    push edx
    mov edx, dword[ebp + 8]
    inc edx
    push edx
    call F
    jmp .out
    
    
 ;   mov edx, 25
  ;  mov dl, byte[base + edx]
  ;  cmp al, dl
  ;  je .n1
  ;  push 25
  ;  push 0
  ;  call F
  ;  jmp .out
;.n1:
;    push 24
 ;   push 1
  ;  call F
 ;   jmp .out        
.next:
    mov edx, dword[ebp + 12]
    ;dec edx
    push edx
    mov edx, dword[ebp + 8]
    ;inc edx
    push edx
    call F  
    ;jmp .fin  
.out:    
        
    mov esp, ebp
    pop ebp
    ret    