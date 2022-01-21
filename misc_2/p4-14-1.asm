%include "io.inc"

section .rodata
    fin db `input.txt`, 0
    fout db `output.txt`, 0
    rmode db `r`, 0
    wmode db `w`, 0
    msg db `%d`, 0
    msg1 db `%d `, 0
    
section .bss
    list resd 1  
    temp resd 1 
    ti resd 1 
    len resd 1

section .data
    mx dd 4000    
    
    
CEXTERN fscanf
CEXTERN fprintf
CEXTERN fopen
CEXTERN fclose
CEXTERN malloc
CEXTERN free

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    push ebx
    and esp, ~15
    sub esp, 16
    mov dword[esp], fin
    mov dword[esp + 4], rmode
    call fopen
    mov dword[ebp - 4], eax
    
    xor ebx, ebx

.L1:
    cmp ebx, dword[mx]
    je .EL1
    mov edx, dword[ebp - 4]
    mov dword[esp], edx
    mov dword[esp + 4], msg
    mov dword[esp + 8], ti
    call fscanf
    cmp eax, -1
    je .EL1
    inc ebx
    inc dword[len]
    cmp ebx, 1
    jne .skip
    mov dword[esp], 8
    call malloc
    mov dword[list], eax
    mov dword[temp], eax
    mov edx, dword[temp]
    mov ecx, dword[ti]
    mov dword[edx], ecx
    jmp .L1
.skip:
    mov dword[esp], 8
    call malloc
    mov edx, dword[temp]
    add edx, 4
    mov dword[edx], eax
    mov dword[temp], eax
    mov edx, dword[temp]
    mov ecx, dword[ti]
    mov dword[edx], ecx
    jmp .L1
.EL1:    
    mov edx, dword[ebp - 4]
    mov dword[esp], edx
    call fclose
 
    xor ebx, ebx
    mov edx, dword[list]           
            
    mov dword[esp], list
    call MERGESORT
        
    mov dword[esp], fout
    mov dword[esp + 4], wmode
    call fopen
    mov dword[ebp - 4], eax
    
    xor ebx, ebx
    mov edx, dword[list]
    mov dword[temp], edx
.FPRINT:
    mov edx, dword[temp]
    cmp ebx, dword[len]
    je .EFPRINT
    mov ecx, dword[edx]
    mov dword[esp + 8], ecx
    mov dword[esp + 4], msg1
    mov ecx, dword[ebp - 4]
    mov dword[esp], ecx
    call fprintf
    mov edx, dword[temp]
    add edx, 4
    mov edx, dword[edx]
    mov dword[temp], edx
    inc ebx
    jmp .FPRINT                             
                                                              
                                                                                           
.EFPRINT:                                                                                                                        
                   
    mov edx, dword[ebp - 4]
    mov dword[esp], edx
    call fclose
    
    mov edx, dword[list]
    mov dword[temp], edx
.DEL:
    mov edx, dword[temp]
    mov ebx, edx
    add ebx, 4
    mov ebx, dword[ebx]
    mov dword[esp], edx
    call free
    test ebx, ebx
    je .EDEL
    mov dword[temp], ebx
    jmp .DEL
.EDEL:                                                                                                                                  
    mov esp, ebp
    sub esp, 4
    pop ebx
    pop ebp
    xor eax, eax
    ret
    
    
MERGESORT:   
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    mov edx, dword[ebp + 8]   
    
    mov edx, dword[edx]

    test edx, edx
    je .RET
    add edx, 4
    mov ecx, dword[edx]
    sub edx, 4
    test ecx, ecx
    je .RET
    mov eax, edx       
    mov ecx, edx
    add ecx, 4
    mov ecx, dword[ecx] 
.WHILE:
    test ecx, ecx
    je .EWHILE        
    add ecx, 4    
    mov ecx, dword[ecx] 
    test ecx, ecx
    je .skip
    add eax, 4
    mov eax, dword[eax] 
    add ecx, 4
    mov ecx, dword[ecx]
.skip:
    jmp .WHILE
.EWHILE:
    mov ecx, edx 
    add eax, 4
    mov edx, dword[eax] 
    mov dword[eax], 0
.EESPLIT:
    mov dword[esp + 8], ecx  
    mov dword[esp + 12], edx 
    lea eax, [esp + 8]
    mov dword[esp], eax
    call MERGESORT   
    lea eax, [esp + 12]
    mov dword[esp], eax
    call MERGESORT   
    
    mov eax, dword[esp + 8]
    mov dword[esp], eax
    mov eax, dword[esp + 12]
    mov dword[esp + 4], eax
    call MERGE
    mov edx, dword[ebp + 8]
    mov dword[edx], eax   

.RET:
    mov esp, ebp
    pop ebp
    ret
  
MERGE:
    push ebp
    mov ebp, esp
    push edi
    push esi
    push ebx
    and esp, ~15
    sub esp, 16
    mov dword[esp + 8], 0 
   
    mov edx, dword[ebp + 8] ;a
    mov ecx, dword[ebp + 12] ;b
    test edx, edx
    jne .s1
    mov eax, ecx
    jmp .RET1
.s1:
    test ecx, ecx
    jne .s2
    mov eax, edx
    jmp .RET1
.s2:    
    mov edi, edx
    mov edi, dword[edi]   
    mov esi, ecx
    mov esi, dword[esi] 
    cmp edi, esi
    jg .next
    mov dword[esp + 8], edx  
    mov edi, dword[esp + 8]
    add edi, 4
    add edx, 4
    mov edx, dword[edx]
    mov dword[esp], edx
    mov dword[esp + 4], ecx
    call MERGE
    mov dword[edi], eax  
    jmp .RET11
.next:
    mov dword[esp + 8], ecx 
    mov edi, dword[esp + 8]
    add edi, 4
    add ecx, 4
    mov ecx, dword[ecx]
    mov dword[esp], edx
    mov dword[esp + 4], ecx
    call MERGE
    mov dword[edi], eax
    jmp .RET11 
.RET11:     
    mov eax, dword[esp + 8]
.RET1:  
    mov esp, ebp
    sub esp, 12
    pop ebx
    pop esi
    pop edi
    pop ebp
    ret    