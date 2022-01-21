%include "io.inc"

section .bss
    a11 resd 1
    a12 resd 1
    a21 resd 1
    a22 resd 1
    b1 resd 1
    b2 resd 1
    x resd 1
    x1 resd 1
    y resd 1
    y1 resd 1
    
section .text
global CMAIN
CMAIN:
    GET_UDEC 4, [a11]
    GET_UDEC 4, [a12]
    GET_UDEC 4, [a21]
    GET_UDEC 4, [a22]
    GET_UDEC 4, [b1]
    GET_UDEC 4, [b2]
      
    mov eax, dword[a12]
    and eax, dword[a21]
    mov ecx, dword[a11]
    and ecx, dword[a22]
    xor eax, ecx
    mov dword[y], eax
    mov eax, dword[b2]
    and eax, dword[a11]
    mov ecx, dword[b1]
    and ecx, dword[a21]
    xor eax, ecx
    and dword[y], eax
    
    and eax, dword[a12]
    xor eax, dword[b1]
    and eax, dword[a11]
    mov dword[x], eax
    
    mov eax, dword[y]
    and eax, dword[a22]
    xor eax, dword[b2]
    and eax, dword[a21]
    or dword[x], eax
    
   
    mov eax, dword[a12]
    xor eax, dword[a22]
    and eax, dword[y]
    xor eax, dword[b2]
    xor eax, dword[b1]
    mov ecx, dword[a11]
    xor ecx, dword[a21]
    and eax, ecx
    or dword[x], eax
    
    mov eax, dword[b1]
    and eax, dword[a22]
    mov ecx, dword[b2]
    and ecx, dword[a12]
    xor eax, ecx
    mov dword[x1], eax
    mov eax, dword[a12]
    and eax, dword[a21]
    mov ecx, dword[a11]
    and ecx, dword[a22]
    xor eax, ecx
    and dword[x1], eax
    mov eax, dword[x1]
    or dword[x], eax
    
    mov eax, dword[x]
    and eax, dword[a11]
    xor eax, dword[b1]
    and eax, dword[a12]
    mov dword[y1], eax
    
    mov eax, dword[x]
    and eax, dword[a21]
    xor eax, dword[b2]
    and eax, dword[a22]
    or dword[y1], eax
    
    mov eax, dword[a11]
    xor eax, dword[a21]
    and eax, dword[x]
    xor eax, dword[b1]
    xor eax, dword[b2]
    mov ecx, dword[a12]
    xor ecx, dword[a22]
    and eax, ecx
    or dword[y1], eax
    
    mov eax, dword[y1]
    or dword[y], eax
    
    PRINT_UDEC 4, [x]
    PRINT_CHAR ' '
    PRINT_UDEC 4, [y]
    xor eax, eax
    ret