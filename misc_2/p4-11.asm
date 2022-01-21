%include "io.inc"

section .rodata
    fin db `input.txt`, 0
    fout db `output.txt`, 0
    ;fin db `/home/boris/prak/asm/input.txt`, 0
    ;fout db `/home/boris/prak/asm/output.txt`, 0
    rmode db `r`, 0
    wmode db `w`, 0
    msg db `%d`, 0
    msg1 db `%d `, 0
    
section .bss
    start resd 1
    temp resd 1
    prev resd 1
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
    
    ;cmp dword[n], 0
    ;je. E
    
    xor ebx, ebx
    mov dword[esp], 8
    call malloc
    mov dword[start], eax
    mov dword[temp], eax
    inc ebx
.LI:
    ;mov dword[esp + 4], msg
    ;mov edx, dword[ebp - 4]
    ;mov dword[esp], edx
    ;mov edx, dword[temp]
    ;add edx, 4
    ;mov dword[esp + 8], edx
    ;call fprintf            ;fscanf(fin, "%d", temp.data);
    mov edx, dword[temp]
    mov dword[edx], ebx
    cmp ebx, dword[n]
    jge .ELI
    mov dword[esp], 8
    call malloc
    mov edx, dword[temp]
    add edx, 4
    mov dword[edx], eax ;temp->next=malloc(8);
    mov dword[temp], eax; temp=temp -> next
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
    
    mov edx, dword[start]
    mov dword[temp], edx
    mov dword[prev], 0
.C1:
    mov edx, dword[temp]
    mov edx, dword[edx]
    cmp edx, dword[p1]
    jne .skip
    cmp dword[prev], 0
    je .CONT
    mov edx, dword[temp]
    ;mov edx, dword[edx]
    mov dword[t1], edx
    add edx, 4
    mov edx, dword[edx]
    mov dword[temp], edx
    jmp .C2
.skip:
    mov edx, dword[temp]
    mov dword[prev], edx
    add edx, 4
    mov edx, dword[edx]
    mov dword[temp], edx
    jmp .C1
    
.C2:
    mov edx, dword[temp]
    mov edx, dword[edx]
    cmp edx, dword[p2]
    jne .skip1
    mov edx, dword[temp]
    mov dword[t2], edx
    jmp .ET
.skip1:
    mov edx, dword[temp]
    add edx, 4
    mov edx, dword[edx]
    mov dword[temp], edx
    jmp .C2
                
.ET:               
    ;mov edx, dword[prev]
    ;test edx, edx
    ;je .CONT
    mov edx, dword[t2]
    add edx, 4
    mov edx, dword[edx] 
    mov ecx, dword[prev]
    add ecx, 4
    mov dword[ecx], edx
    mov edx, dword[t2]
    add edx, 4
    mov ecx, dword[start]
    mov dword[edx], ecx
    mov edx, dword[t1]
    mov dword[start], edx
.CONT:    
    inc ebx
    jmp .PROC
    
                    
.branch:
    mov edx, dword[start]
    mov dword[temp], edx
    mov dword[prev], 0
.CC1:
    mov edx, dword[temp]
    mov edx, dword[edx]
    cmp edx, dword[p1]
    jne .skip2
    cmp dword[prev], 0
    je .CONT1
    mov edx, dword[temp]
    mov dword[t1], edx
    jmp .ETT
.skip2:
    mov edx, dword[temp]
    mov dword[prev], edx
    add edx, 4
    mov edx, dword[edx]
    mov dword[temp], edx
    jmp .CC1 
    
.ETT:
    ;mov edx, dword[prev]
    ;test edx, edx
    ;je .CONT1
    mov edx, dword[t1] 
    add edx, 4
    mov edx, dword[edx]
    mov ecx, dword[prev]
    add ecx, 4
    mov dword[ecx], edx
    mov edx, dword[t1]
    add edx, 4
    mov ecx, dword[start]
    mov dword[edx], ecx
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
;---------------------------------
;    mov edx, dword[start]
;    mov dword[temp], edx
;.PRINT:
;    mov edx, dword[temp]
;    mov ebx, edx
;    mov ebx, dword[ebx]
;    add edx, 4
;    mov edx, dword[edx]
;    PRINT_DEC 4, ebx
;    NEWLINE
;    test edx, edx
;    je .EPRINT
;    mov dword[temp], edx
;    jmp .PRINT
;.EPRINT:
    
;----------------------------------    
    mov edx, dword[start]
    mov dword[temp], edx
    xor ebx, ebx    
    
.FPRINT:
    ;mov ecx, dword[edx]
    mov edx, dword[temp]
    mov edx, dword[edx]
    mov dword[esp + 4], msg1
    mov dword[esp + 8], edx
    mov ecx, dword[ebp - 4]
    mov dword[esp], ecx
    call fprintf
    mov edx, dword[temp]
    add edx, 4
    mov edx, dword[edx]
    mov dword[temp], edx
    inc ebx
    cmp ebx, dword[n]
    ;PRINT_DEC 4, ebx
    ;NEWLINE
    jl .FPRINT
    
    mov edx, dword[ebp - 4]
    mov dword[esp], edx
    call fclose
    
    mov edx, dword[start]
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
    
;    mov edx, dword[start]
;    mov dword[temp], edx
;.PRINT:
;    mov edx, dword[temp]
;    mov ebx, edx
;    mov ebx, dword[ebx]
;    add edx, 4
;    mov edx, dword[edx]
;    PRINT_DEC 4, ebx
;    NEWLINE
;    test edx, edx
;    je .EPRINT
;    mov dword[temp], edx
;    jmp .PRINT
;.EPRINT:
    
    mov esp, ebp
    sub esp, 4
    pop ebx
    pop ebp
    xor eax, eax
    ret