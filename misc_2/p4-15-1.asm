%include "io.inc"

section .rodata
    msg db `%s`, 0
    msgp db `|`, 0
    msgs db ` `, 0
    sn db `\n`, 0
    
CEXTERN scanf
CEXTERN printf
CEXTERN strcmp
CEXTERN strlen
CEXTERN qsort
CEXTERN malloc
CEXTERN atoi
CEXTERN strcpy
section .bss
    arr resd 600000
    s resd 1
    st resb 1000002
    len resd 1
    ml1 resd 1
    ml2 resd 1
    ml3 resd 1   
    ft resd 1 
    tp resd 1
    
section .data
    sz dd 1000002
    sz1 dd 6
    sz2 dd 3


section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 32
    
    xor edi, edi
    xor esi, esi
.L:

    

    
    mov dword[esp], msg
    mov dword[esp + 4], s
    call scanf
    cmp eax, -1
    je .EL
    mov dword[esp], s
    call strlen
    cmp eax, dword[ml1]
    jle .s1
    mov dword[ml1], eax
.s1:    
    mov dword[esp], eax
    inc dword[esp]
    call malloc   
    

    mov dword[arr + 4 * edi], eax
    mov edx, dword[arr + 4 * edi]
    mov dword[esp], edx
    mov dword[esp + 4], s
    call strcpy
  
    
    inc esi
    inc edi
    
    mov dword[esp], msg
    mov dword[esp + 4], s
    call scanf
    
    mov dword[esp], s
    call strlen
    cmp eax, dword[ml2]
    jle .s2
    mov dword[ml2], eax
.s2: 
    mov dword[esp], eax
    inc dword[esp]
    call malloc
    mov dword[arr + 4 * edi], eax
    mov edx, dword[arr + 4 * edi]
    mov dword[esp], edx 
    mov dword[esp + 4], s
    call strcpy


    
    
    inc edi
    

    mov dword[esp], msg
    mov dword[esp + 4], s
    call scanf
    
    mov dword[esp], s
    call strlen
    cmp eax, dword[ml3]
    jle .s3
    mov dword[ml3], eax
.s3:   
    mov dword[esp], eax
    inc dword[esp]
    call malloc
    mov dword[arr + 4 * edi], eax
    mov edx, dword[arr + 4 * edi]
    mov dword[esp], edx
    
    mov dword[esp + 4],s

    call strcpy
        cmp eax, -1
    je .EL
     

    
    inc edi
    jmp .L                      
.EL: 

    mov dword[len], esi
     
 
     
     
    mov dword[esp], arr
    mov edx, dword[len]
    mov dword[esp + 4], edx
    mov dword[esp + 8], 12
    mov dword[esp + 12], F
    call qsort    
                
                                                  
    xor edi, edi
    xor esi, esi
.P:
    cmp edi, dword[len]
    je .EP
    mov edx, dword[arr + 4 * esi]
    mov dword[esp], edx
    call strlen
    mov edx, dword[ml1]
    sub edx, eax
    mov dword[tp], edx
    mov edx, dword[arr + 4 * esi]
    mov dword[esp + 4], edx
    mov dword[esp], msg
    call printf
    xor ebx, ebx
.ES1:           
    cmp ebx, dword[tp]  
    jge .EES1
    mov dword[esp], msgs
    call printf
    inc ebx
    jmp .ES1     
.EES1:           
    mov dword[esp], msgp
    call printf
    
    inc esi
    
    mov edx, dword[arr + 4 * esi]
    mov dword[esp], edx
    call strlen
    mov edx, dword[ml2]
    sub edx, eax
    mov dword[tp], edx
    xor ebx, ebx
.ES2:    
    cmp ebx, dword[tp]
    jge .EES2
    mov dword[esp], msgs
    call printf
    inc ebx
    jmp .ES2
.EES2:    
    mov edx, dword[arr + 4 * esi]
    mov dword[esp + 4], edx
    mov dword[esp], msg
    call printf
           
    mov dword[esp], msgp
    call printf
    
    inc esi
    
    mov edx, dword[arr + 4 * esi]
    mov dword[esp], edx
    call strlen
    mov edx, dword[ml3]
    sub edx, eax
    mov dword[tp], edx
    xor ebx, ebx
.ES3:
    cmp ebx, dword[tp]
    jge .EES3 
    mov dword[esp], msgs
    call printf
    inc ebx
    jmp .ES3
.EES3:     
    
    mov edx, dword[arr + 4 * esi]
    mov dword[esp + 4], edx
    mov dword[esp], msg
    call printf
           
    mov dword[esp], sn
    call printf
    
    inc esi            
    inc edi
    jmp .P                                                                                                                            
    
    
.EP:    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
    
    
    
F:
    push ebp
    mov ebp, esp
    push edi
    push esi
    push ebx
    and esp, ~15
    sub esp, 32
    
    mov edi, dword[ebp + 8]
 
    mov esi, dword[ebp + 12]
   
    add edi, 8
    add esi, 8
    mov edi, dword[edi]
    mov esi, dword[esi] 

    mov dword[esp], edi
    call atoi
    mov ebx, eax
    
    mov dword[esp], esi
    call atoi
    cmp ebx, eax
    
    jg .l
    jl .h
    
    mov edi, dword[ebp + 8]
    mov esi, dword[ebp + 12]
    add edi, 4
    add esi, 4
    mov edi, dword[edi]
    mov esi, dword[esi]
    
    mov dword[esp], edi
    call atoi
    mov ebx, eax
    
    mov dword[esp], esi
    call atoi
    cmp ebx, eax
    
    jl .l
    jg .h
    

    mov edi, dword[ebp + 8]
    mov esi, dword[ebp + 12]
    mov edi, dword[edi]
    mov esi, dword[esi]    
    mov dword[esp], edi
    mov dword[esp + 4], esi
    call strcmp
    
    cmp eax, 0
    jl .l
    jg .h
    je .n    
.h:
    mov eax, 1 
    jmp .out
.l:
    mov eax, -1
    jmp .out
.n:
    xor eax, eax
    jmp .out                           
                          
            
.out:                
    mov esp, ebp
    sub esp, 12
    pop ebx
    pop esi
    pop edi
    pop ebp
    ret                    