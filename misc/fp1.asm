%include "io.inc"

section .rodata
    msg db `%lf`, 0
    msgi db `%d`, 0
    
CEXTERN scanf
CEXTERN printf
CEXTERN getchar

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 32
    
    mov dword[esp], msg
    lea edx, [esp + 16]
    mov dword[esp + 4], edx
    call scanf
    
   ; call getchar
    
    
    mov dword[esp], msg
    lea edx, [esp + 24]
    mov dword[esp + 4], edx
    call scanf
   
   
    xor eax, eax
    
    finit
    fld qword[esp + 24]
    fld qword[esp + 16]
    fucomip st1
      
    finit
    
    ja .C1
    jb .C2
    jmp .out
.C1:
    mov eax, 1
    jmp .out
.C2:
    mov eax, -1
.out:
    mov dword[esp], msgi
    mov dword[esp + 4], eax
    call printf             
    
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret