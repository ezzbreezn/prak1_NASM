%include "io.inc"


section .rodata
    msg db `%lf`, 0

section .bss
    x resd 2

CEXTERN scanf
CEXTERN printf

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msg
    mov dword[esp + 4], x
    call scanf

    
    mov edx, dword[x]
    mov dword[esp], edx
    mov edx, dword[x + 4]
    mov dword[esp + 4], edx
    call F1
    
    fstp qword[esp + 4]
    mov dword[esp], msg
    call printf
    
    NEWLINE
    
    mov edx, dword[x]
    mov dword[esp], edx
    mov edx, dword[x + 4]
    mov dword[esp + 4], edx
    call F2
    
    
    fstp qword[esp + 4]
    mov dword[esp], msg
    call printf
    
    NEWLINE
    
    mov edx, dword[x]
    mov dword[esp], edx
    mov edx, dword[x + 4]
    mov dword[esp + 4], edx
    call F3
    
    fstp qword[esp + 4]
    mov dword[esp], msg
    call printf
    
    NEWLINE
    
    mov edx, dword[x]
    mov dword[esp], edx
    mov edx, dword[x + 4]
    mov dword[esp + 4], edx
    call DF1
    
    fstp qword[esp + 4]
    mov dword[esp], msg
    call printf
    
    NEWLINE
    
    mov edx, dword[x]
    mov dword[esp], edx
    mov edx, dword[x + 4]
    mov dword[esp + 4], edx
    call DF2
    
    fstp qword[esp + 4]
    mov dword[esp], msg
    call printf
    
    NEWLINE
    
    mov edx, dword[x]
    mov dword[esp], edx
    mov edx, dword[x + 4]
    mov dword[esp + 4], edx
    call DF3
    
    fstp qword[esp + 4]
    mov dword[esp], msg
    call printf
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
;e^x + 2
global F1
F1:
    push ebp
    mov ebp, esp
    ;and esp, ~15
    sub esp, 16
    
    finit
    
    fld qword[ebp + 8]
    fldl2e
    fmulp 
    fld st0
    frndint
    fsub st1, st0
    fxch
    f2xm1
    fld1
    faddp
    fscale
    fstp st1
    fld1
    fld1
    faddp
    faddp
      
    mov esp, ebp
    pop ebp
    ret  
  

;-1/x  
global F2
F2:
    push ebp
    mov ebp, esp
    ;and esp, ~15
    sub esp, 16
    
    finit
    
    fld1
    fld qword[ebp + 8]
    fdivp
    fchs        
            
    mov esp, ebp
    pop ebp
    ret  
    
;-2(x + 1)/3
global F3
F3:
    push ebp
    mov ebp, esp 
    ;and esp, ~15
    sub esp, 16
    
    finit
    
    fld qword[ebp + 8]
    fld1
    fld1
    faddp
    fmulp
    fld1
    fld1
    faddp
    faddp
    fld1
    fld1
    fld1
    faddp
    faddp
    fdivp
    fchs
    
    
                                                    
    mov esp, ebp
    pop ebp
    ret 
     
;e^x 
global DF1 
DF1:
    push ebp
    mov ebp, esp
    ;and esp, ~15
    sub esp, 16
    
    finit
    fld qword[ebp + 8]
    fldl2e
    fmulp
    fld st0
    frndint
    fsub st1, st0
    fxch
    f2xm1
    fld1
    faddp
    fscale
    fstp st1
                                                                                                                                                                                            
    mov esp, ebp
    pop ebp
    ret  
  
;1/(x^2) 
global DF2 
DF2:
    push ebp
    mov ebp, esp
    ;and esp, ~15
    sub esp, 16
    
    finit
    fld1
    fld qword[ebp + 8]
    fdivp
    fld qword[ebp + 8]
    fdivp
    
    mov esp, ebp
    pop ebp
    ret
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
;-2/3 
global DF3                                               
DF3:
    push ebp
    mov ebp, esp
    ;and esp, ~15
    sub esp, 16
    
    finit
    fld1
    fld1
    faddp
    fld1
    fld1
    fld1
    faddp
    faddp
    fdivp
    fchs
    
    
    mov esp, ebp
    pop ebp
    ret    
                                                                                                                                                                                                                                                                       