%include "io.inc"

section .rodata
    msg db `%d`, 0
    msg1 db `%d `, 0
    fin db `input.bin`, 0
    rmode db `rb`, 0
    
section .bss
    root resd 1
    f resd 1
    a resd 20000
    b resd 20000
    i resd 1
    j resd 1
    x resd 1
    y resd 1
    t resd 1
    shift resd 1

CEXTERN fopen
CEXTERN fclose
CEXTERN fread
CEXTERN fseek
CEXTERN malloc
CEXTERN qsort


section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], fin
    mov dword[esp + 4], rmode
    call fopen
    mov dword[f], eax ; f = fopen('input.bin', 'rb');
    
.L:
    mov dword[esp], x
    mov dword[esp + 4], 4
    mov dword[esp + 8], 1
    mov edx, dword[f]
    mov dword[esp + 12], edx
    call fread
    
    test eax, eax
    je .EL
    
    mov ecx, dword[i]
    mov edx, dword[x]
    mov dword[a + 8 * ecx], edx ; a[2*i]=x
    mov edx, dword[shift]
    mov dword[a + 8 * ecx + 4], edx ;a[2*i+1]=shift
    
    mov dword[esp], x
    mov dword[esp + 4], 4
    mov dword[esp + 8], 1
    mov edx, dword[f]
    mov dword[esp + 12], edx
    call fread
    
    cmp dword[x], -1 ;LO
    je .skip1
    
    mov edx, dword[f]
    mov dword[esp], edx
    mov edx, dword[x]
    mov dword[esp + 4], edx
    mov dword[esp + 8], 0
    call fseek ;fseek(f, x, 0)

    mov dword[esp], y
    mov dword[esp + 4], 4
    mov dword[esp + 8], 1
    mov edx, dword[f]
    mov dword[esp + 12], edx
    call fread
    
    mov ecx, dword[j]
    mov edx, dword[y]
    mov dword[b + 8 * ecx], edx ;b[2*j]=y
    mov edx, dword[x]
    mov dword[b + 8 * ecx + 4], edx ;b[2*j+1]=x
    inc dword[j]
    
    mov edx, dword[f]
    mov dword[esp], edx
    mov edx, dword[shift]
    mov dword[esp + 4], edx
    mov dword[esp + 8], 0
    call fseek
    
    mov dword[esp], x
    mov dword[esp + 4], 4
    mov dword[esp + 8], 1
    mov edx, dword[f]
    mov dword[esp + 12], edx
    call fread
    
    mov dword[esp], x
    mov dword[esp + 4], 4
    mov dword[esp + 8], 1
    mov edx, dword[f]
    mov dword[esp + 12], edx
    call fread            
    
.skip1:    

    mov dword[esp], x
    mov dword[esp + 4], 4
    mov dword[esp + 8], 1
    mov edx, dword[f]
    mov dword[esp + 12], edx
    call fread
    
    cmp dword[x], -1 ;RO
    je .skip2
    
        mov edx, dword[f]
    mov dword[esp], edx
    mov edx, dword[x]
    mov dword[esp + 4], edx
    mov dword[esp + 8], 0
    call fseek ;fseek(f, x, 0)

    mov dword[esp], y
    mov dword[esp + 4], 4
    mov dword[esp + 8], 1
    mov edx, dword[f]
    mov dword[esp + 12], edx
    call fread
    
    mov ecx, dword[j]
    mov edx, dword[y]
    mov dword[b + 8 * ecx], edx ;b[2*j]=y
    mov edx, dword[x]
    mov dword[b + 8 * ecx + 4], edx ;b[2*j+1]=x
    inc dword[j]
    
    mov edx, dword[f]
    mov dword[esp], edx
    mov edx, dword[shift]
    mov dword[esp + 4], edx
    mov dword[esp + 8], 0
    call fseek
    
    mov dword[esp], x
    mov dword[esp + 4], 4
    mov dword[esp + 8], 1
    mov edx, dword[f]
    mov dword[esp + 12], edx
    call fread
    
    mov dword[esp], x
    mov dword[esp + 4], 4
    mov dword[esp + 8], 1
    mov edx, dword[f]
    mov dword[esp + 12], edx
    call fread     
    
    mov dword[esp], x
    mov dword[esp + 4], 4
    mov dword[esp + 8], 1
    mov edx, dword[f]
    mov dword[esp + 12], edx
    call fread
    
    
.skip2:   

    inc dword[i]
    add dword[shift], 12
    jmp .L 
      
.EL:  
    
    mov dword[esp], a
    mov edx, dword[i]
    mov dword[esp + 4], edx
    mov dword[esp + 8], 8
    mov dword[esp + 12], COMP
    call qsort
    
    mov dword[esp], b
    mov edx, dword[j]
    mov dword[esp + 4], edx
    mov dword[esp + 8], 8
    mov dword[esp + 12], COMP
    call qsort
    
    
.RF:
    mov edx, dword[j]
    cmp dword[t], edx
    je .ERF
    mov ecx, dword[t]
    mov edx, dword[a + 8 * ecx]
    cmp edx, dword[b + 8 * ecx]
    jne .ERF
    mov edx, dword[a + 8 * ecx + 4]
    cmp edx, dword[b + 8 * ecx + 4]
    jne .ERF
    inc dword[t]
    jmp .RF  
.ERF:   

    mov edx, dword[f]
    mov dword[esp], edx
    mov dword[esp + 4], 0
    mov dword[esp + 8], 0
    call fseek
    
    mov edx, dword[f]
    mov dword[esp], edx
    mov ecx, dword[t]
    mov edx, dword[a + 8 * ecx + 4]
    mov dword[esp + 4], edx
    call BUILD
    
    mov dword[root], eax ;root = build(f, a[2*t+1])
    
    mov edx, dword[f]
    mov dword[esp], edx
    call fclose
    
    mov edx, dword[root]
    mov dword[esp], edx
    call NLR
      
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
    
COMP:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    mov ecx, dword[ebp + 8] ; a
    mov edx, dword[ebp + 12] ;b
    mov edi, ecx
    mov esi, edx
    mov ecx, dword[ecx] ;a key
    mov edx, dword[edx] ;b key
    add edi, 4
    mov edi, dword[edi] ;a shift
    add esi, 4
    mov esi, dword[esi] ;b shift
    
    cmp ecx, edx ;a key == b key
    je .LE
    jl .L
.G:    
    mov eax, 1
    jmp .OUT
.LE:
    cmp edi, esi ;a shift == b shift
    jl .L
    jg .G
    xor eax, eax
    jmp .OUT
.L:
    mov eax, -1
    jmp .OUT        
    
.OUT:    
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    ret
    
BUILD:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], 12
    call malloc
    
    mov dword[ebp - 4], eax
    
    mov edx, dword[ebp + 8]
    mov dword[esp], edx
    mov edx, dword[ebp + 12]
    mov dword[esp + 4], edx
    mov dword[esp + 8], 0
    call fseek
    
    lea edx, [ebp - 8] ; local var x
    mov dword[esp], edx
    mov dword[esp + 4], 4
    mov dword[esp + 8], 1
    mov edx, dword[ebp + 8]
    mov dword[esp + 12], edx
    call fread
    
    mov edx, dword[ebp - 4]
    mov ecx, dword[ebp - 8]
    mov dword[edx], ecx ; node ->key = x
    
    lea edx, [ebp - 8]
    mov dword[esp], edx
    mov dword[esp + 4], 4
    mov dword[esp + 8], 1
    mov edx, dword[ebp + 8]
    mov dword[esp + 12], edx
    call fread
    
    cmp dword[ebp - 8], -1;x== -1
    jne .next
    mov edx, dword[ebp - 4]
    mov dword[edx + 4], 0; node -> left = NULL
    jmp .L1
.next:

    mov edx, dword[ebp + 8]
    mov dword[esp], edx
    mov dword[esp + 4], 0
    mov dword[esp + 8], 0
    call fseek
    
    mov edx, dword[ebp + 8]
    mov dword[esp], edx
    mov edx, dword[ebp - 8]
    mov dword[esp + 4], edx
    call BUILD
    
    mov edx, dword[ebp - 4]
    mov dword[edx + 4], eax ; node->left = build(f, x)
    
    mov edx, dword[ebp + 8]
    mov dword[esp], edx
    mov edx, dword[ebp + 12]
    mov dword[esp + 4], edx
    mov dword[esp + 8], 0
    call fseek
    
    
    lea edx, [ebp - 8]
    mov dword[esp], edx
    mov dword[esp + 4], 4
    mov dword[esp + 8], 1
    mov edx, dword[ebp + 8]
    mov dword[esp + 12], edx
    call fread
    
    lea edx, [ebp - 8]
    mov dword[esp], edx
    mov dword[esp + 4], 4
    mov dword[esp + 8], 1
    mov edx, dword[ebp + 8]
    mov dword[esp + 12], edx
    call fread
.L1:

    lea edx, [ebp - 8]
    mov dword[esp], edx
    mov dword[esp + 4], 4
    mov dword[esp + 8], 1
    mov edx, dword[ebp + 8]
    mov dword[esp + 12], edx
    call fread    
        
    cmp dword[ebp - 8], -1
    jne .next1
    mov edx, dword[ebp - 4]
    mov dword[edx + 8], 0 
    jmp .OUT
.next1:
    mov edx, dword[ebp + 8]
    mov dword[esp], edx
    mov dword[esp + 4], 0
    mov dword[esp + 8], 0
    call fseek
    
    mov edx, dword[ebp + 8]
    mov dword[esp], edx
    mov edx, dword[ebp - 8]
    mov dword[esp + 4], edx
    call BUILD
    
    mov edx, dword[ebp - 4]
    mov dword[edx + 8], eax ;node->right = build(f, x)                                        
   
          
.OUT:        
    mov eax, dword[ebp - 4]
    mov esp, ebp
    pop ebp
    ret    
    
NLR:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov edx, dword[ebp + 8]
    test edx, edx
    je .OUT
    
    mov ecx, dword[edx]
    mov dword[esp], msg1
    mov dword[esp + 4], ecx
    call printf
    
    mov edx, dword[ebp + 8]
    mov ecx, dword[edx + 4]
    mov dword[esp], ecx
    call NLR
    
    mov edx, dword[ebp + 8]
    mov ecx, dword[edx + 8]
    mov dword[esp], ecx
    call NLR
    
    
.OUT:        
    mov esp, ebp
    pop ebp
    ret            