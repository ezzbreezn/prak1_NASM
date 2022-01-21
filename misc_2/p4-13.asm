%include "io.inc"

section .rodata
    msg db `%d`, 0
    msgo db `%d\n`, 0

CEXTERN scanf
CEXTERN printf
CEXTERN fprintf
CEXTERN get_stdout


section .bss
    arr resd 1000000
    n resd 1
    stdout resd 1

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 32
    
    mov dword[esp], msg
    mov dword[esp + 4], n
    call scanf
    
    xor edi, edi
.L:
    cmp edi, dword[n]
    je .EL
    mov dword[esp], msg
    lea edx, [arr + 4 * edi]
    mov dword[esp + 4], edx
    call scanf
    inc edi
    jmp .L
.EL:            
    
    call get_stdout
    mov dword[stdout], eax
    
    mov dword[esp], arr
    mov edx, dword[n]
    mov dword[esp + 4], edx
    mov dword[esp + 8], fprintf
    mov dword[esp + 12], 2
    mov edx, dword[stdout]
    mov dword[esp + 16], edx
    mov dword[esp + 20], msgo
    call APPLY
    
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
APPLY:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 32
    
    mov edi, dword[ebp + 8]
    xor esi, esi
.L:
    cmp esi, dword[ebp + 12]
    je .EL
    mov edx, dword[ebp + 24]
    mov dword[esp], edx
    mov edx, dword[ebp+ 28]
    mov dword[esp + 4], edx  
    mov edx, dword[edi +  4 * esi]
    mov dword[esp + 8], edx
    mov edx, dword[ebp + 16]
    call edx
    inc esi
    jmp .L  
.EL:            
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    ret       