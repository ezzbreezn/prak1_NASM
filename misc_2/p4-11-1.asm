%include "io.inc"

section .rodata
    fin db `input.txt`, 0
    fout db `output.txt`, 0
    rmode db `r`, 0
    wmode db `w`, 0
    msg db `%d`, 0
    msg1 db `%d `, 0
    
section .bss
    start resd 1
    temp resd 1
    links resd 1
    t1 resd 1
    t2 resd 1
    n resd 1
    m resd 1
    p1 resd 1
    p2 resd 1    
    
CEXTERN fopen
CEXTERN fclose
CEXTERN fscanf
CEXTERN fprintf
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
    mov dword[esp + 4], rmode
    mov dword[esp], fin
    call fopen
    mov dword[ebp - 4], eax
    
    mov dword[esp + 8], n
    mov dword[esp + 4], msg
    mov edx, dword[ebp - 4]
    mov dword[esp], edx
    call fscanf
    
    mov dword[esp + 8], m
    mov dword[esp + 4], msg
    mov edx, dword[ebp - 4]
    call fscanf
       
    mov edx, dword[n]
    sal edx, 2
    mov dword[esp], edx
    call malloc
    mov dword[links], eax
    
    xor ebx, ebx
    mov dword[esp], 12
    call malloc
    mov dword[start], eax
    mov dword[temp], eax
    mov ecx, dword[links]
    mov dword[ecx], eax
    inc ebx
.LI:
    mov edx, dword[temp]
    mov dword[edx], ebx
    cmp ebx, dword[n]
    jge .ELI
    mov dword[esp], 12
    call malloc
    mov ecx, dword[links]
    mov dword[ecx + 4 * ebx], eax
    mov edx, dword[temp]
    add edx, 8
    mov dword[edx], eax 
    mov edx, dword[temp]
    mov dword[eax + 4], edx
    mov dword[temp], eax
    inc ebx
    jmp .LI
.ELI: 

    xor ebx, ebx
.PROC:
    cmp ebx, dword[m]
    jge .EPROC  
    mov dword[esp + 8], p1
    mov dword[esp + 4], msg
    mov edx, dword[ebp - 4]
    mov dword[esp], edx
    call fscanf
    mov dword[esp + 8], p2
    mov dword[esp + 4], msg
    mov edx, dword[ebp - 4]
    mov dword[esp], edx
    call fscanf
    
    mov edx, dword[p1]
    cmp dword[p2], edx
    je .branch
    
    mov ecx, dword[p1]
    mov edx, dword[links]
    mov eax, dword[edx + 4 * ecx - 4]
    mov dword[t1], eax
    mov ecx, dword[p2]
    mov eax, dword[edx + 4 * ecx - 4]
    mov dword[t2], eax
    
    mov edx, dword[t1]
    add edx, 4
    mov edx, dword[edx]
    test edx, edx
    je .CONT
    
    mov ecx, dword[t2]
    add ecx, 8
    mov ecx, dword[ecx]
    test ecx, ecx
    je .n1
    add ecx, 4
    mov dword[ecx], edx
.n1:
    mov ecx, dword[t2]
    add ecx, 8
    mov ecx, dword[ecx]
    add edx, 8
    mov dword[edx], ecx
    mov ecx, dword[t2]
    add ecx, 8
    mov edx, dword[start]
    mov dword[ecx], edx
    mov edx, dword[start]
    add edx, 4
    mov ecx, dword[t2]
    mov dword[edx], ecx
    mov edx, dword[t1]
    add edx, 4
    mov dword[edx], 0
    mov edx, dword[t1]
    mov dword[start], edx
    
.CONT:
    inc ebx
    jmp .PROC 
    
.branch:
    mov ecx, dword[p1]
    mov edx, dword[links]
    mov eax, dword[edx + 4 * ecx - 4]
    mov dword[t1], eax
    mov edx, dword[t1]
    add edx, 4
    mov edx, dword[edx]
    test edx, edx
    je .CONT1
    
    mov ecx, dword[t1]
    add ecx, 8
    mov ecx, dword[ecx]
    test ecx, ecx
    je .n2
    add ecx, 4
    mov dword[ecx], edx
.n2:
    mov ecx, dword[t1]
    add ecx, 8
    mov ecx, dword[ecx]
    mov edx, dword[t1]
    add edx, 4
    mov edx, dword[edx]
    add edx, 8
    mov dword[edx], ecx
    mov ecx, dword[t1]
    add ecx, 8
    mov edx, dword[start]
    mov dword[ecx], edx
    mov edx, dword[start]
    add edx, 4
    mov ecx, dword[t1]
    mov dword[edx], ecx
    mov edx, dword[t1]
    add edx, 4
    mov dword[edx], 0
    mov edx, dword[t1]
    mov dword[start], edx
    
.CONT1:
    inc ebx
    jmp .PROC
          
.EPROC:                                                             
                                                      
    mov edx, dword[ebp - 4]
    mov dword[esp], edx
    call fclose
    
    
    mov dword[esp], fout
    mov dword[esp + 4], wmode
    call fopen
    
    mov dword[ebp - 4], eax
    
    mov edx, dword[start]
    xor ebx, ebx
    
   
    mov edx, dword[start]
    mov dword[temp], edx
    xor ebx, ebx    
    
.FPRINT:
    mov edx, dword[temp]
    mov edx, dword[edx]
    mov dword[esp + 4], msg1
    mov dword[esp + 8], edx
    mov ecx, dword[ebp - 4]
    mov dword[esp], ecx
    call fprintf
    mov edx, dword[temp]
    add edx, 8
    mov edx, dword[edx]
    mov dword[temp], edx
    inc ebx
    cmp ebx, dword[n]
    jl .FPRINT
    
    mov edx, dword[ebp - 4]
    mov dword[esp], edx
    call fclose
    
    mov edx, dword[start]
    mov dword[temp], edx
.DEL:
    mov edx, dword[temp]
    mov ebx, edx
    add ebx, 8
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