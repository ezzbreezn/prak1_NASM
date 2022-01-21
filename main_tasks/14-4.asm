%include "io.inc"

section .rodata
    msg db `%d`, 0
    msgo db `%d `, 0
    
section .bss
    a resd 1
    b resd 1
    ans resd 1
    
CEXTERN scanf
CEXTERN printf

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msg
    mov dword[esp + 4], a
    call scanf
    
    mov dword[esp], msg
    mov dword[esp + 4], b
    call scanf
    
    push dword[b]
    push dword[a]
    push ans
    call WRAPPER
    add esp, 12
    
    mov dword[esp], msgo
    mov edx, dword[ans]
    mov dword[esp + 4], edx
    call printf
    mov edx, dword[ans + 4]
    mov dword[esp + 8], edx
    call printf
    
    
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    xor eax, eax
    ret
    
ACTUAL:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    mov edx, dword[ebp + 8]
    mov ecx, dword[ebp + 12]
    mov dword[edx], ecx
    mov ecx, dword[ebp + 16]
    mov dword[edx + 4], ecx   
         
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    ret    
    
WRAPPER:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    mov ecx, dword[ebp + 8]
    mov dword[esp], ecx
    mov ecx, dword[ebp + 12]
    mov dword[esp + 4], ecx
    mov ecx, dword[ebp + 16]
    mov dword[esp + 8], ecx
    call ACTUAL
    
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    ret