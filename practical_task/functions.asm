;Functions from the main task

section .text
;F1 = e^x + 2
global F1
F1:
    push ebp
    mov ebp, esp
    and esp, ~15
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
  

;F2 = -1/x  
global F2
F2:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    finit
    
    fld1
    fld qword[ebp + 8]
    fdivp
    fchs        
            
    mov esp, ebp
    pop ebp
    ret  
    
;F3 = -2(x + 1)/3
global F3
F3:
    push ebp
    mov ebp, esp 
    and esp, ~15
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
     
;dF1 = e^x 
global DF1 
DF1:
    push ebp
    mov ebp, esp
    and esp, ~15
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
  
;dF2 = 1/(x^2) 
global DF2 
DF2:
    push ebp
    mov ebp, esp
    and esp, ~15
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
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
;dF3 = -2/3 
global DF3                                               
DF3:
    push ebp
    mov ebp, esp
    and esp, ~15
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
