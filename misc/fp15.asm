%include "io.inc"

section .rodata
    msg db `%lf`, 0
    msgi db `%d`, 0
    
section .bss
    n resd 1    
    
CEXTERN scanf
CEXTERN printf

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    push edi
    push ebx
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msgi
    mov dword[esp + 4], n
    call scanf
    
    mov ebx, dword[n]
    sal ebx, 3
    add ebx, 4
    add ebx, 16
    mov edx, dword[n]
    lea eax, [esp]
    sub eax, ebx
    mov dword[eax], edx
    xor edi, edi
    sub ebx, 4
    
.L:
    cmp edi, dword[n]
    je .EL
    
    lea edx, [esp]
    sub edx, ebx
    mov dword[esp + 4], edx
    mov dword[esp], msg
    call scanf
    inc edi
    sub ebx, 8
    jmp .L        
.EL:   
    mov ebx, dword[n]
    sal ebx, 3
    add ebx, 4
    add ebx, 16
    sub esp, edx
    call F
 
    fstp qword[esp + 4]
    mov dword[esp], msg
    call printf
     
    mov esp, ebp
    sub esp, 8
    pop ebx
    pop edi
    pop ebp
    xor eax, eax
    ret
    
F:
    push ebp
    mov ebp, esp
    push esi
    and esp, ~15
    sub esp, 16
    
    finit
    xor esi, esi
.L:
    cmp esi, dword[ebp + 8]
    je .EL
    
    fld qword[ebp + 8 + 8 * esi]
    inc esi
    cmp esi, 1
    je .skip
    faddp
.skip:
    jmp .L            
.EL:   
    fild dword[ebp + 8]
    fdivp  
           
    mov esp, ebp
    sub esp, 4
    pop esi
    pop ebp
    ret                