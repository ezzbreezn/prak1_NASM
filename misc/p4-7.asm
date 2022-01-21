%include "io.inc"

section .rodata
    msg db `%s`, 0
    msgi db `%d`, 0
    
CEXTERN scanf
CEXTERN printf   
CEXTERN strcmp
CEXTERN malloc
CEXTERN free
CEXTERN qsort
CEXTERN realloc 

section .bss
    arr resd 5500
    n resd 1
    ans resd 1

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msgi
    mov dword[esp + 4], n
    call scanf
    
    
    xor edi, edi
.L:
    cmp edi, dword[n]
    jge .EL
    mov dword[esp], msg
    mov eax, edi
    mov edx, 11
    mul edx
    lea edx, [arr + eax]
    mov dword[esp + 4], edx
    call scanf
    
    inc edi
    jmp .L

.EL:    
    mov dword[esp], arr
    mov edx, dword[n]
    mov dword[esp + 4], edx
    mov dword[esp + 8], 11
    mov dword[esp + 12], F
    call qsort
    
    mov edi, 1
.LC:
    cmp edi, dword[n]
    je .ELC
    mov eax, 11
    mul edi
    lea edx, [arr + eax]
    sub eax, 11
    lea ecx, [arr + eax]
    mov dword[esp], edx
    mov dword[esp + 4], ecx
    call strcmp
    test eax, eax
    je .skip
    inc dword[ans]
.skip:
    inc edi
    jmp .LC    
            
            
.ELC:    
    inc dword[ans]
    mov edx, dword[ans]
    mov dword[esp], msgi
    mov dword[esp + 4], edx
    call printf
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
    
F:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov edx, dword[ebp + 8]
    mov ecx, dword[ebp + 12]
    
    mov dword[esp], edx
    mov dword[esp + 4], ecx
    call strcmp    
            
    mov esp, ebp
    pop ebp
    ret                