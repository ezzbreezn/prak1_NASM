%include "io.inc"

section .rodata
    fin db `input.txt`, 0
    rmode db `r`, 0
    fout db `output.txt`, 0
    wmode db `w`, 0
    msg db `%d`, 0
    msgo db `%d `, 0
    
    
CEXTERN fscanf
CEXTERN fprintf
CEXTERN fopen
CEXTERN fclose
CEXTERN qsort

section .bss
    f resd 1
    a resd 2000

section .text
global CMAIN
CMAIN:
    ;write your code here
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], fin
    mov dword[esp + 4], rmode
    call fopen

    mov dword[f], eax
    
    xor edi, edi
.L:
    mov edx, dword[f]
    mov dword[esp], edx
    mov dword[esp + 4], msg
    lea edx, [a + 4 * edi]
    mov dword[esp + 8], edx
    call fscanf
    
    cmp eax, -1
    je .EL
    
    inc edi
    jmp .L
    
.EL:    
    
    mov edx, dword[f]
    mov dword[esp], edx
    call fclose
    
    mov dword[esp], a
    mov dword[esp + 4], edi
    mov dword[esp + 8], 4
    mov dword[esp + 12], COMP
    call qsort
    
    mov dword[esp], fout
    mov dword[esp + 4], wmode
    call fopen
    
    mov dword[f], eax
    
    xor esi, esi

.L1: 
    cmp esi, edi
    je .EL1
    mov edx, dword[f]
    mov dword[esp], edx
    mov dword[esp + 4], msgo
    mov edx, dword[a + 4 * esi]
    mov dword[esp + 8], edx
    call fprintf
    
    inc esi
    jmp .L1
    
.EL1:    

    
    mov edx, dword[f]
    mov dword[esp], edx
    call fclose
    
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
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
    
    mov ecx, dword[ebp + 8]
    mov edx, dword[ebp + 12]
    mov ecx, dword[ecx]
    mov edx, dword[edx]
    cmp ecx, edx
    jl .l
    jg .g
    xor eax, eax
    jmp .out
.l:
    mov eax, -1
    jmp .out    
.g:
    mov eax, 1    
    
.out:    
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    ret