%include "io.inc"

section .rodata
    msgi db `%lf`, 0
    msgo db `%.3lf`, 0
    
section .bss
    x resd 2
    y resd 2  
    max resd 2
    min resd 2  
    
    
CEXTERN scanf
CEXTERN printf

section .data
    const dd 0.35    

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 32
    
    
    mov dword[esp], msgi
    mov dword[esp + 4], x
    call scanf
    
    mov dword[esp], msgi
    mov dword[esp + 4], y
    call scanf
    
    finit
    fld qword[x]
    fabs
    fld qword[y]
    fabs
    fucomi st1
    
    finit
    ja .C1
    mov edx, dword[x]
    mov dword[max], edx
    mov edx, dword[x + 4]
    mov dword[max + 4], edx
    
    mov edx, dword[y]
    mov dword[min], edx
    mov edx, dword[y + 4]
    mov dword[min + 4], edx
    
    jmp .next
.C1:

    mov edx, dword[y]
    mov dword[max], edx
    mov edx, dword[y + 4]
    mov dword[max + 4], edx
    
    mov edx, dword[x]
    mov dword[min], edx
    mov edx, dword[x + 4]
    mov dword[min + 4], edx
    
.next:
    
    fld qword[max]
    fabs
    fld qword[min]
    fabs
    fld dword[const]
    fmulp
    faddp
    
    fstp qword[esp + 16]          
    
    mov dword[esp], msgo
    mov edx, dword[esp + 16]
    mov dword[esp + 4], edx
    mov edx, dword[esp + 20]
    mov dword[esp + 8], edx
    call printf
    
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret