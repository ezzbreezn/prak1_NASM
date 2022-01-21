%include "io.inc"

section .rodata
    msg db `%d`, 0
    msg1 db `%d `, 0
    fin db `input.txt`, 0
    fout db `output.txt`, 0
    rmode db `r`, 0
    wmode db `w`, 0

section .bss
    array resd 1
    len resd 1
    
section .data
    size dd 1000

CEXTERN printf
CEXTERN fscanf
CEXTERN fprintf
CEXTERN fopen
CEXTERN fclose
CEXTERN qsort
CEXTERN malloc
CEXTERN realloc
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
   
    mov dword[ebp - 4], eax;
    
    mov edx, dword[size]
    sal edx, 2
    mov dword[esp], edx
    call malloc
    mov dword[array], eax
    
    xor ebx, ebx
.L:
    cmp ebx, 1000
    je .EL
    cmp ebx, dword[size]
    jl .skip
    mov edx, dword[array]
    mov dword[esp], edx
    sal dword[size], 1
    mov edx, dword[size]
    sal edx, 2
    mov dword[esp + 4], edx
    call realloc
    mov dword[array], eax
.skip:
    mov edx, dword[array]
    lea edx, [edx + 4 * ebx]
    mov dword[esp + 8], edx
    mov edx, dword[ebp - 4]
    mov dword[esp], edx
    mov dword[esp + 4], msg
    call fscanf
    cmp eax, -1
    je .EL
    inc ebx
    jmp .L
.EL:
    mov dword[len], ebx

    mov edx, dword[ebp - 4]
    mov dword[esp], edx
    call fclose
    
    test ebx, ebx
    je .EM
    
    mov dword[esp + 12], F
    mov edx, dword[len]
    mov dword[esp + 8], 4
    mov dword[esp + 4], edx
    mov edx, dword[array]
    mov dword[esp], edx
    call qsort
    
.EM:
    mov dword[esp], fout
    mov dword[esp + 4], wmode
    call fopen
    mov dword[ebp - 4], eax 
    
    test ebx, ebx
    je .EL1
    
    xor ebx, ebx
    
.L1:
    cmp ebx, dword[len]
    je .EL1
    mov edx, dword[array]
    lea edx, [edx + 4 * ebx]
    mov edx, dword[edx]
    mov dword[esp + 8], edx
    mov dword[esp + 4], msg1
    mov edx, dword[ebp - 4]
    mov dword[esp], edx
    call fprintf
    inc ebx
    jmp .L1
    
.EL1:
    
    mov edx, dword[ebp - 4]
    mov dword[esp], edx
    call fclose 
    
.END:
    mov edx, dword[array]
    mov dword[esp], edx
    call free
    
    mov esp, ebp
    sub esp, 4
    pop ebx
    pop ebp
    xor eax, eax
    ret

F:
    push ebp
    mov ebp, esp
    mov ecx, dword[ebp + 8]
    mov edx, dword[ebp + 12]
    mov ecx, dword[ecx]
    mov edx, dword[edx]
    cmp ecx, edx
    je .C1
    jg .C2
    mov eax, -1
    jmp .end
.C1:
    xor eax, eax
    jmp .end
.C2:
    mov eax, 1
.end:
    mov esp, ebp
    pop ebp
    ret