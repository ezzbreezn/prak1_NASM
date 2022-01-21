%include "io.inc"

section .rodata
    msgd db `%d`, 0
    msgf db `%lf`, 0
    pa db `YES`, 0
    na db `NO`, 0
    
    
CEXTERN scanf
CEXTERN printf

section .bss
    a resd 9

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msgd
    lea edx, [a]
    mov dword[esp + 4], edx
    call scanf
    
    mov dword[esp], msgf
    lea edx, [a + 4]
    mov dword[esp + 4], edx
    call scanf
    
    mov dword[esp], msgf
    lea edx, [a + 12]
    mov dword[esp +4 ], edx
    call scanf
    
    mov dword[esp], msgf
    lea edx, [a + 20]
    mov dword[esp + 4], edx
    call scanf
    
    cmp dword[a], 1
    jne .skip
    
    mov dword[esp], msgf
    lea edx, [a + 28]
    mov dword[esp + 4], edx
    call scanf
    
    
    
.skip:

    finit
    cmp dword[a], 1
    je .CMYK
    
    fld qword[a + 4]
    fld1
    fucomip
    je .next1
    jmp .out
.next1:
    fstp st0
    fld qword[a + 12]
    fld1
    fucomip
    je .next2
    jmp .out
.next2:
    fstp st0
    fld qword[a + 20]
    fld1
    fucomip
    jne .out        
    jmp .pout
.CMYK:
    fld qword[a + 4]
    fldz
    fucomip
    je .nnext1
    jmp .out
.nnext1:
    fstp st0
    fld qword[a + 12]
    fldz
    fucomip
    je .nnext2
    jmp .out
.nnext2:
    fstp st0
    fld qword[a + 20]
    fldz
    fucomip
    je .nnext3
    jmp .out
.nnext3:
    fstp st0
    fld qword[a + 28]
    fldz
    fucomip
    jne .out
    jmp .pout
         
     
     
.pout:     
    finit
    mov dword[esp], pa
    call printf
    jmp .fin 
.out:
    finit
    mov dword[esp], na
    call printf
    
.fin:           
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    xor eax, eax
    ret