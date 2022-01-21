%include "io.inc"

section .rodata
    msg db `%c`, 0
    msgs db `%s`, 0
  
  
CEXTERN printf
CEXTERN malloc
CEXTERN scanf

section .bss
    y resd 1

section .text
global CMAIN
CMAIN:
    ;write your code here
    push ebp
    mov ebp, esp
    sub esp, 16
    
    mov dword[y], SAS
    
    mov dword[esp], 4
    mov ecx, dword[y]
    
    call ecx
    
    movsx ax, byte[eax]
    
    mov dword[esp], msg
    mov dword[esp + 4], eax
    call printf
    
    mov esp, ebp
    pop ebp
    
    xor eax, eax
    ret
    
SAS:
    push ebp
    mov ebp, esp
    push esi
    sub esp, 16
    mov dword[esp], 10
    call malloc
    
    mov esi, eax
    
    mov dword[esp], msgs
    mov dword[esp + 4], eax
    call scanf
    
    mov eax, esi
    
    mov esp, ebp
    sub esp, 4
    pop esi
    pop ebp
    ret    