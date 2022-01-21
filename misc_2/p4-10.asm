%include "io.inc"

section .rodata
    msgd db `%d`, 0
    msgdd db `%d%d`, 0
    msgc db `%c`, 0
    msg1 db `%d %d\n`, 0

section .bss
    op resb 1
    root resd 1
    ans resd 1

CEXTERN malloc
CEXTERN free
CEXTERN scanf
CEXTERN printf
CEXTERN getchar

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msgc
    mov dword[esp + 4], op
    call scanf

.INPUT:
    cmp byte[op], 'F'
    je .OUT
    
    cmp byte[op], 'A'
    je .insert
    cmp byte[op], 'D'
    je .delete
    cmp byte[op], 'S'
    je .search
.insert:
    mov dword[esp], msgdd
    lea edx, [ebp - 4] ; val
    mov dword[esp + 4], edx
    lea edx, [ebp - 8] ; data
    mov dword[esp + 8], edx
    call scanf
    
    mov edx, dword[ebp - 4]
    
    ;PRINT_DEC 4, edx
    ;NEWLINE
    
    mov dword[esp + 4], edx ;val
    mov edx, dword[root]
    ;mov dword[esp], root
    mov dword[esp], edx
    call SEARCH
    mov dword[ans], eax
    test eax, eax
    jne .change
    
    mov dword[esp], root
    mov edx, dword[ebp - 4] ;val
    mov dword[esp + 4], edx
    mov edx, dword[ebp - 8] ;data
    mov dword[esp + 8], edx
    call INSERT
    
    mov dword[root], eax
    ;mov edx, dword[root]
    ;PRINT_DEC 4, [edx]
    ;NEWLINE
    ;add edx, 12
    ;mov edx, dword[edx]
    ;test edx, edx
    ;je .NEWINPUT
    ;PRINT_DEC 4, [edx]
    ;PRINT_STRING `\n#\n`
    jmp .NEWINPUT

    
.change:
    mov edx, dword[ans]
    add edx, 4
    mov ecx, dword[ebp - 8]
    mov dword[edx], ecx
    jmp .NEWINPUT
    
    
.delete:
    lea edx, [ebp - 4] ; val
    mov dword[esp + 4], edx
    mov dword[esp], msgd
    call scanf
    
    mov dword[esp], root
    mov edx, dword[ebp - 4]
    mov dword[esp + 4], edx
    call DELETE
    jmp .NEWINPUT
    
.search:
    lea edx, [ebp - 4]; val
    mov dword[esp + 4], edx
    mov dword[esp], msgd
    call scanf

    mov edx, dword[ebp - 4]
    mov dword[esp + 4], edx
    ;mov dword[esp], root
    mov edx, dword[root]
    mov dword[esp], edx
    call SEARCH

    mov dword[ans], eax
    test eax, eax
    je .NF
    mov edx, dword[ans]
    mov ecx, dword[edx]
    mov dword[esp + 4], ecx
    add edx, 4
    mov ecx, dword[edx]
    mov dword[esp + 8], ecx
    mov dword[esp], msg1
    call printf
.NF:
    jmp .NEWINPUT
    
.NEWINPUT:
    ;call getchar    

    mov dword[esp], msgc
    mov dword[esp + 4], op
    call scanf
    ;PRINT_CHAR  [op]
    ;NEWLINE
    ;PRINT_STRING `ZBS\n`
    jmp .INPUT
    
    
.OUT:    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
    
    
;#################################SEARCH##########################################    
SEARCH:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov edx, dword[ebp + 8] ; s
    ;mov ecx, dword[ebp + 12] ;val
    ;----------------------------
    ;mov edx, dword[edx]
    ;-------------------------

    test edx, edx
    je .L1
    ;PRINT_DEC 4, [edx]
    ;NEWLINE
    mov ecx, dword[edx] ;s->key

    cmp ecx, dword[ebp + 12] ;s->key==val
    je .L1
    
    jg .L2
    mov ecx, dword[ebp + 12]
    mov dword[esp + 4], ecx  ;val
    mov ecx, dword[edx + 12]; s->right
    mov dword[esp], ecx
    call SEARCH
    jmp .ESEARCH
    
.L2:
    mov ecx, dword[ebp + 12]
    mov dword[esp + 4], ecx ; val
    mov ecx, dword[edx + 8] ;s->left
    mov dword[esp], ecx
    call SEARCH
    jmp .ESEARCH
.L1:
    ;PRINT_CHAR '#'
    mov eax, dword[ebp + 8] ;s
    ;-----------------------
    ;mov eax, dword[eax]
    ;-------------------------
    
.ESEARCH:        
    mov esp, ebp
    pop ebp
    ret    
    
    
    
;#############################INSERT###################################    
INSERT:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov edx, dword[ebp + 8] ;s
    mov edx, dword[edx]
    test edx, edx
    jne .L
    ;s==NULL
    mov dword[esp], 20
    call malloc
    
    mov dword[ebp - 4], eax; s
    mov edx, dword[ebp + 12];val
    mov dword[eax], edx
    mov edx, dword[ebp + 16] ;data
    mov dword[eax + 4], edx
    mov dword[eax + 8], 0 ;s->left
    mov dword[eax + 12] ,0; s->right
    
    mov dword[esp], eax
    call GETBALANCE
    ;eax <- s
    ;PRINT_DEC 4, eax
    ;NEWLINE
    mov edx, dword[ebp - 4]
    ;PRINT_DEC 4, [edx]
    ;NEWLINE
    add edx, 16
    mov dword[edx], eax
    mov eax, dword[ebp - 4]

    jmp .EINSERT
    
.L:
    
    mov ecx, dword[ebp + 12];val
    ;PRINT_DEC 4, ecx
    ;NEWLINE
    cmp ecx, dword[edx]
    jge .L1
    ;mov ecx, dword[edx + 8]; s->left
    lea ecx, [edx + 8]
    mov dword[esp], ecx
    mov ecx, dword[ebp + 12]; val
    mov dword[esp + 4], ecx
    mov ecx, dword[ebp + 16]; data
    mov dword[esp + 8], ecx
    call INSERT
    mov edx, dword[ebp + 8]
    ;-------------------------------
    mov edx, dword[edx]
    ;-------------------------------
    add edx, 8
    mov dword[edx], eax ;s->left = insert(s->left, val, data)
    jmp .EEI
 
.L1:
    ;mov ecx, dword[edx + 12] ;s->right
    lea ecx, [edx + 12]
    mov dword[esp], ecx
    mov ecx, dword[ebp + 12]; val
    mov dword[esp + 4], ecx
    mov ecx, dword[ebp + 16]; data
    mov dword[esp + 8], ecx
    call INSERT

    mov edx, dword[ebp + 8]
    ;------------------------------
    mov edx, dword[edx]
    ;------------------------------
    add edx, 12
    mov dword[edx], eax ;s->right=insert(s->right, val, data)
    mov edx, dword[edx]
    ;PRINT_DEC 4, [edx]
    ;NEWLINE
.EEI:
    mov edx, dword[ebp + 8]
    ;---------------------------
    mov edx, dword[edx]
    ;--------------------------
    mov dword[esp], edx
    call BALANCE
    ;mov dword[ebp + 8], eax
    jmp .EINSERT
   
    
.EINSERT:
    
    mov esp, ebp
    pop ebp

    ret
    
    
;#######################################DELETE#######################################
DELETE:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov eax, dword[ebp + 8] ;s
    test eax, eax
    je .EEDELETE
    
    mov edx, eax
    mov ecx, dword[ebp + 12] ; val
    cmp ecx, dword[edx] ;val cmp s->key    
    jl .L
    jg .G
    add edx, 8
    mov ecx, dword[edx] ;s->left
    mov dword[ebp - 4], ecx; l=s->left            
    add edx, 4
    mov ecx, dword[edx] ; s->right
    mov dword[ebp - 8], ecx ; r=s->right
    
    mov edx, dword[ebp + 8]
    mov dword[esp], edx
    call free ;free(s)
    cmp dword[ebp - 8], 0 ;r == NULL
    jne .skip
    mov eax, dword[ebp - 4]; l
    jmp .EDELETE
.skip:    
    mov edx, dword[ebp - 8]
    mov dword[esp], edx
    call FINDMIN
    mov dword[ebp - 12], eax ; m = findmin(r)
    add eax, 8
    mov edx, dword[ebp - 4]
    mov dword[eax], edx ; m->left = l
    
    mov edx, dword[ebp - 8]
    mov dword[esp], edx
    call SUBMIN
    mov edx, dword[ebp - 12]
    add edx, 12
    mov dword[edx], eax ; m->right = submin(r)
    mov edx, dword[ebp - 12]
    mov dword[esp], edx
    call BALANCE ; balance(m)
    jmp .EDELETE
    
.L:
    mov edx, dword[ebp + 8]
    add edx, 8
    mov edx, dword[edx] ; s->left
    mov dword[esp], edx
    mov edx, dword[ebp + 12]
    mov dword[esp + 4], edx; val
    call DELETE
    mov edx, dword[ebp + 8]
    add edx, 8
    mov dword[edx], eax ;s->left = delete(s->left, val)
    jmp .EDELETE
    
.G:
    mov edx, dword[ebp + 8]
    add edx, 12
    mov edx, dword[edx]; s->right
    mov dword[esp], edx
    mov edx, dword[ebp + 12];val
    mov dword[esp + 4], edx
    call DELETE
    mov edx, dword[ebp + 8]
    add edx, 12
    mov dword[edx], eax
    jmp .EDELETE
    
    
    
.EDELETE: 
    mov edx, dword[ebp + 8]
    mov dword[esp], edx
    call BALANCE ; balance(s)
    
.EEDELETE:             
    mov esp, ebp
    pop ebp
    ret
    
    
;####################################SUBMIN######################################
SUBMIN:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov edx, dword[ebp + 8] ;s
    add edx, 8
    cmp dword[edx], 0 ; s->left == NULL
    jne .skip
    add edx, 4
    mov eax, dword[edx] ; s->right
    jmp .EESUBMIN
.skip:
    mov edx, dword[edx]
    mov dword[esp], edx
    call SUBMIN
    mov edx, dword[ebp + 8]
    add edx, 8
    mov dword[edx], eax ; s->left = submin(s->left)
    
    mov edx, dword[ebp + 8]
    mov dword[esp], edx
    call BALANCE ; balance(s)
    
.EESUBMIN:
    mov esp, ebp
    pop ebp
    ret    
    
;####################################BALANCE##################################
BALANCE:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov edx, dword[ebp + 8]
    mov dword[esp], edx
    call GETBALANCE  ;getbalance(s)
    mov edx, dword[ebp + 8]
    mov dword[esp], edx
    call BALANCEFACT ; balancefact(s)
    cmp eax, 2
    jne .skip
    mov edx, dword[ebp + 8]
    add edx, 12
    mov edx, dword[edx]
    mov dword[esp], edx
    call BALANCEFACT  ;balancefact(s->right)
    
    cmp eax, 0
    jge .L
    
    mov edx, dword[ebp + 8]
    add edx, 12
    mov edx, dword[edx]
    mov dword[esp], edx
    call ROTATERIGHT 
    
    mov edx, dword[ebp + 8]
    add edx, 12
    mov dword[edx], eax ;s->right = rotateright(s->right)
.L:
    mov edx, dword[ebp + 8]
    mov dword[esp], edx
    call ROTATELEFT  ;rotateleft(s)
    jmp .EBALANCE
    
.skip:
    cmp eax, -2
    jne .R
    mov edx, dword[ebp + 8]
    add edx, 8
    ;PRINT_DEC 4, [edx]
    mov edx, dword[edx]
    mov dword[esp], edx
    call BALANCEFACT   ;balancefact(s->left)
    cmp eax, 0
    jle .L1
    
    mov edx, dword[ebp + 8]
    add edx, 8
    mov edx, dword[edx]
    mov dword[esp], edx
    call ROTATELEFT
    
    mov edx, dword[ebp + 8]
    add edx, 8
    mov dword[edx], eax ; s->left=rotateleft(s->left)
.L1:
    mov edx, dword[ebp + 8]
    mov dword[esp], edx
    call ROTATERIGHT
    jmp .EBALANCE
            
.R:
    
    mov eax, dword[ebp + 8]       
.EBALANCE: 
    mov esp, ebp
    pop ebp
    ret   
    
     
;#############################ROTATELEFT#########################################
ROTATELEFT:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
     
    mov edx, dword[ebp + 8]
    add edx, 12
    mov edx, dword[edx]
    mov dword[ebp - 4], edx ; q=s->right
    
    add edx, 8
    mov edx, dword[edx] ; q->left == (s->right)->left
    mov ecx, dword[ebp + 8]
    add ecx, 12
    mov dword[ecx], edx ; s->right = q -> left
    
    mov ecx, dword[ebp + 8]
    mov edx, dword[ebp - 4]
    add edx, 8
    mov dword[edx], ecx ; q->left = s
    
    mov edx, dword[ebp + 8]
    mov dword[esp], edx
    call GETBALANCE  ;getbalance(s)
    
    mov edx, dword[ebp - 4]
    mov dword[esp], edx
    call GETBALANCE ;getbalance(q)
    
    mov eax, dword[ebp - 4] ;q
     
    mov esp, ebp
    pop ebp
    ret 
    
    
;#################################ROTATERIGHT#################################
ROTATERIGHT:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov edx, dword[ebp + 8]
    add edx, 8
    mov edx, dword[edx]
    mov dword[ebp - 4], edx ; q=s->left
    
    add edx, 12
    mov edx, dword[edx] ; q->right == (s->left)->right
    mov ecx, dword[ebp + 8]
    add ecx, 8
    mov dword[ecx], edx ; s->left = q->right
    
    mov ecx, dword[ebp + 8]
    mov edx, dword[ebp - 4]
    add edx, 12
    mov dword[edx], ecx ; q->right = s
    
    mov edx, dword[ebp + 8]
    mov dword[esp], edx
    call GETBALANCE ;getbalance(s)
    
    mov edx, dword[ebp - 4]
    mov dword[esp], edx
    call GETBALANCE ; getbalance(q)
    
    mov eax, dword[ebp - 4]     ;q
    
    mov esp, ebp
    pop ebp
    ret
    
               
;###############################GETBALANCE##################################
GETBALANCE:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov edx, dword[ebp + 8]
    add edx, 8
    mov edx, dword[edx]
    mov dword[esp], edx
    call HEIGHT  ;height(s->left)
    
    mov dword[ebp - 4], eax
    
    mov edx, dword[ebp + 8]
    add edx, 12
    mov edx, dword[edx]
    mov dword[esp], edx
    call HEIGHT; height(s->right)
    
    mov dword[ebp - 8], eax
    
    mov ecx, dword[ebp - 4]
    mov edx, dword[ebp - 8]
    cmp ecx, edx ; height(s->left) cmp height(s->right)
    jg .skip
    mov eax, edx ;height(s->right)
    jmp .EGETBALANCE
.skip:
    mov eax, ecx ;height(s->left)
.EGETBALANCE:
    inc eax    
    
    mov edx, dword[ebp + 8]
    add edx, 16
    mov dword[edx], eax ; s->height <- res                                                                          
    mov esp, ebp
    pop ebp
    ret     
    
;#############################BALANCEFACT####################################
BALANCEFACT:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov edx, dword[ebp + 8]
    add edx, 8
    mov edx, dword[edx]
    mov dword[esp], edx
    call HEIGHT ; height(s->left)
    mov dword[ebp - 4], eax
    
    mov edx, dword[ebp + 8]
    add edx, 12
    mov edx, dword[edx]
    mov dword[esp], edx
    call HEIGHT ;height(s->right)
    mov edx, dword[ebp - 4]
    sub eax, edx ; height(s->right)-height(s->left)
                                                                                                                                                                                                                            
    mov esp, ebp
    pop ebp
    ret      
    
;################################HEIGHT########################################
HEIGHT:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov edx, dword[ebp + 8]
    test edx, edx
    jne .skip
    xor eax, eax
    jmp .EHEIGHT
.skip:
    add edx, 16
    mov eax, dword[edx] ; s->height    
    
.EHEIGHT:    
    mov esp, ebp
    pop ebp
    ret
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
;#################################FINDMIN#####################################
FINDMIN:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov edx, dword[ebp + 8]
    test edx, edx ; s==NULL
    je .L
    add edx, 8
    mov edx, dword[edx] 
    test edx, edx   ;s->left == NULL
    je .L
    
    mov edx, dword[ebp + 8]
    add edx, 8
    mov edx, dword[edx]
    mov dword[esp], edx
    call FINDMIN  ;findmin(s->left)
    jmp .EFINDMIN
.L:
    mov eax, dword[ebp + 8]
  
.EFINDMIN:      
    mov esp, ebp
    pop ebp
    ret                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  