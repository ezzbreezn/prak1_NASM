%include "io.inc"

section .rodata
    msg db `%d`, 0
    
CEXTERN scanf
CEXTERN printf

section .bss
    a resd 4
    pa resd 1
    pb resd 1
    
    

section .text
global CMAIN
CMAIN:
    ;write your code here
    push ebp
    mov ebp, esp
    push edi
    sub esp, 20
    
    mov dword[esp], msg
    mov dword[esp + 4], a
    call scanf
    lea edi, [a + 4]
    mov dword[esp +4 ], edi
    call scanf
    lea edi, [a + 8]
    mov dword[esp + 4], edi
    call scanf
    lea edi, [a + 12]
    mov dword[esp + 4], edi
    call scanf
    
    mov dword[pa], a
    mov dword[pb], a
    add dword[pb], 8
    mov ecx, dword[pa]
    mov dword[esp], ecx
    mov ecx, dword[pb]
    mov dword[esp + 4], ecx
    call F
    
    mov dword[esp], msg
    mov dword[esp + 4], eax
    call printf
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
    
F:
    push ebp
    mov ebp, esp
    sub esp, 12
    
    mov ecx, dword[ebp + 8]
    mov ecx, dword[ecx]
    mov dword[esp], ecx
    mov ecx, dword[ebp + 12]
    dec dword[ecx]
    mov ecx, dword[ecx]
    add dword[esp], ecx
    mov ecx, dword[ebp + 8]
    add ecx, 4
    mov ecx, dword[ecx]
    add dword[esp], ecx
    mov eax, dword[esp]
    
    
    
    mov esp, ebp
    pop ebp
    ret