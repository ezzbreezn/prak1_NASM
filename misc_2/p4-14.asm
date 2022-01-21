%include "io.inc"

section .rodata
    fin db `/home/boris/prak/asm/input.txt`, 0
    fout db `/home/boris/prak/asm/output.txt`, 0
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
    mov ebp, esp; for correct debugging
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
 
;**************************************************
    xor ebx, ebx
    mov edx, dword[list]
;.PRINT:
;    cmp ebx, dword[len]
;    je .EPRINT
;    mov ecx, dword[edx]
;    PRINT_DEC 4, ecx
;    NEWLINE
;    add edx, 4
;    mov edx, dword[edx]
;    inc ebx
;    jmp .PRINT
;.EPRINT:
;***************************************************           
            
    mov dword[esp], list
    call MERGESORT
    
    
;**************************************************
;    xor ebx, ebx
;    mov edx, dword[list]
;.PRINT:
;    cmp ebx, dword[len]
;    je .EPRINT
;    mov ecx, dword[edx]
;    PRINT_DEC 4, ecx
;    NEWLINE
;    add edx, 4
;    mov edx, dword[edx]
;    inc ebx
;    jmp .PRINT
;.EPRINT:
;***************************************************    
    
    
    
    
    
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
;**************************************************
;    xor ebx, ebx
;    mov edx, dword[list]
;.PRINT:
;    cmp ebx, dword[len]
;    je .EPRINT
;    mov ecx, dword[edx]
;    PRINT_DEC 4, ecx
;    NEWLINE
;    add edx, 4
;    mov edx, dword[edx]
;    inc ebx
;    jmp .PRINT
;.EPRINT:
;***************************************************
    mov esp, ebp
    sub esp, 4
    pop ebx
    pop ebp
    xor eax, eax
    ret
    
    
MERGESORT:   ;  void mergesort(list **head)
    push ebp
    mov ebp, esp
    push edi
    push esi
    push ebx
    and esp, ~15
    sub esp, 16
    mov edx, dword[ebp + 8]   ;edx - *head
    ;esp + 12 - *a
    ;esp + 8 - *b
    
    mov edx, dword[edx]

    test edx, edx
    je .RET
    ;PRINT_DEC 4, [edx]
    ;NEWLINE
    add edx, 4
    mov ecx, dword[edx]
    sub edx, 4
    ;PRINT_DEC 4, ecx
    ;NEWLINE
    test ecx, ecx
    je .RET
    ;------------split---------------------------------
    mov eax, edx        ; *head ,   slow
    mov ecx, edx
    add ecx, 4
    mov ecx, dword[ecx] ; *head->next   , fast 
    ;PRINT_DEC 4, [eax]
    ;NEWLINE
    ;PRINT_DEC 4, [ecx]
    ;NEWLINE
    ;NEWLINE
    
   ; test eax, eax
   ; je .ESPLIT
   ; test ecx, ecx
   ; je .ESPLIT
   ; jmp .WHILE
;.ESPLIT:
  ;  mov ecx, edx
  ;  mov edx, 0
   ; jmp .EESPLIT
.WHILE:
    test ecx, ecx
    je .EWHILE        
    add ecx, 4    
    mov ecx, dword[ecx] ;  fast= fast->next
    test ecx, ecx
    je .skip
    add eax, 4
    mov eax, dword[eax] ; slow=slow->next
    add ecx, 4
    mov ecx, dword[ecx]; fast=fast->next
.skip:
    jmp .WHILE
.EWHILE:
    mov ecx, edx ;first=head
    add eax, 4
    mov edx, dword[eax] ; last=slow->next
    ;PRINT_DEC 4, [ecx]
    ;NEWLINE
    ;PRINT_DEC 4, edx
    ;NEWLINE
    mov dword[eax], 0
    ;------------------------------------
.EESPLIT:
    mov dword[esp + 8], ecx  ;first
    mov dword[esp + 12], edx ;last
    lea eax, [esp + 8]
    mov dword[esp], eax
    call MERGESORT   ;mergesort(&first)
    lea eax, [esp + 12]
    mov dword[esp], eax
    call MERGESORT   ;mergesort(&last)
    ;lea eax, [esp + 8]
    
    
;#################################################################################    
    mov edx, dword[esp + 8] ;first
    mov ecx, dword[esp + 12] ;last
    mov ebx, 0
    test edx, edx
    jne .step1
    mov ebx, ecx
    jmp .ENDMERGE
.step1:
    test ecx, ecx
    jne .step2
    mov ebx, edx
    jmp .ENDMERGE
.step2:
    mov edi, dword[edx]
   ; mov edi, dword[edi]
    mov esi, dword[ecx]
    ;mov esi, dword[esi]
    PRINT_DEC 4, edi
    NEWLINE
    PRINT_DEC 4, esi
    NEWLINE
    NEWLINE
    cmp edi, esi
    jge .step3
    mov ebx, edx
    add edx, 4
    mov edx, dword[edx]
    jmp .EE
.step3:
    mov edx, ecx
    add ecx, 4
    mov ecx, dword[ecx]
.EE:
    mov eax, ebx
    
.WL:
    test edx, edx
    je .EWL
    test ecx, ecx
    je .EWL
    mov edi, dword[edx]
    mov esi, dword[ecx]
    cmp edi, esi
    jge .step4
    add ebx, 4
    mov dword[ebx], edx
    add edx, 4
    mov edx, dword[edx]
    jmp .WW
.step4:
    add ebx, 4
    mov dword[ebx], ecx
    add ecx, 4
    mov ecx, dword[ecx]
.WW:
    mov ebx, dword[ebx]
    jmp .WL
.EWL:    

    test edx, edx
    je .EWA
.WA:
    test edx, edx
    je .EWA
    add ebx, 4
    mov dword[ebx], edx
    mov ebx, dword[ebx]
    add edx, 4
    mov edx, dword[edx]
    jmp .WA
.EWA:
    test ecx, ecx
    je .EWB
    
.WB:
    test ecx, ecx
    je .EWB
    add ebx, 4
    mov dword[ebx], ecx
    mov ebx, dword[ebx]
    add ecx, 4
    mov ecx, dword[ecx]
    jmp .WB
.EWB:
    mov ebx, eax
    
    mov edx, dword[ebp + 8]
    mov dword[edx], ebx
    

;    mov eax, dword[esp + 8]
;    mov dword[esp], eax
;    mov eax, dword[esp + 12]
;    mov dword[esp + 4], eax
;    call MERGE
;    mov edx, dword[ebp + 8]
;    mov dword[edx], eax   ;*head=merge(first, last)
    
    
        ;mov edx, dword[edx]
        ;mov ecx, dword[edx]
    ;PRINT_DEC 4, ecx
    ;NEWLINE
    ;add edx, 4
    ;mov edx, dword[edx]
    ;PRINT_DEC 4, edx
    ;NEWLINE
    ;PRINT_STRING `-------------\n`
.ENDMERGE:    
.RET:
    mov esp, ebp
    sub esp, 12
    pop ebx
    pop esi
    pop edi
    pop ebp
    ret
    
    
    
    
    
;######################################################################    
;MERGE:
;    push ebp
;    mov ebp, esp
;    ;PRINT_STRING `IN\n`
;    ;PRINT_DEC 4, edi
;    ;NEWLINE
;    push edi
;    push esi
;    push ebx
;    and esp, ~15
;    sub esp, 16
;    mov dword[esp + 8], 0 ; res = NULL
    
;    mov edx, dword[ebp + 8] ;a
;    mov ecx, dword[ebp + 12] ;b
;    ;PRINT_DEC 4, edx
;    ;NEWLINE
;    ;PRINT_DEC 4, ecx
;    ;NEWLINE
;    test edx, edx
;    jne .s1
;    mov eax, ecx
;    jmp .RET1
;.s1:
;    test ecx, ecx
;    jne .s2
;    mov eax, edx
;    jmp .RET1
;.s2:    
;   ; PRINT_STRING `ok\n`
;    mov edi, edx
;    mov edi, dword[edi]   ; a->data
;    mov esi, ecx
;    mov esi, dword[esi]   ; b-> data
;    cmp edi, esi
;    jg .next
;    mov dword[esp + 8], edx  ;res = a
;    mov edi, dword[esp + 8]
;    add edi, 4
;    add edx, 4
;    mov edx, dword[edx]
;    mov dword[esp], edx
;    mov dword[esp + 4], ecx
;    ;PRINT_DEC 4, edx
;    ;NEWLINE
;    ;PRINT_DEC 4, ecx
;    ;NEWLINE
    
;    ;PRINT_DEC 4, edi
;    ;NEWLINE
;    call MERGE
;    ;PRINT_STRING `HUI\n`
;    ;PRINT_DEC 4, eax
;    ;NEWLINE
;    mov dword[edi], eax  ;res->next=merge(a->next, b)
;    jmp .RET1
;.next:
;    mov dword[esp + 8], ecx ;res = b
;    mov edi, dword[esp + 8]
;    add edi, 4
;    add ecx, 4
;    mov ecx, dword[ecx]
;    mov dword[esp], edx
;    mov dword[esp + 4], ecx
;    ;PRINT_DEC 4, edi
;    ;NEWLINE
;    call MERGE
;    ;PRINT_STRING `hui\n`
;    ;PRINT_DEC 4, eax
;    ;NEWLINE
;    mov dword[edi], eax 
;.RET1:   
;    mov eax, dword[esp + 8]  
;    mov esp, ebp
;    sub esp, 12
;    pop ebx
;    pop esi
;    pop edi
;    ;PRINT_STRING `RET\n`
;    ;PRINT_DEC 4, edi
;    ;NEWLINE
;    pop ebp
;    ret    