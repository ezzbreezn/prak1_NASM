%include "io.inc"

section .rodata
    msg db `%d`, 0
    msgo db `%d `, 0
    msgl db `%lld`, 0
    fin db `/home/boris/prak/asm/sassasm/input.txt`, 0
    rmode db `r`, 0
    fout db `/home/boris/prak/asm/sassasm/output.txt`, 0
    wmode db `w`, 0
    
section .bss
    res resd 2
    f resd 1
    temp resd 1
    
CEXTERN fscanf
CEXTERN fprintf
CEXTERN fopen
CEXTERN fclose

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], fin
    mov dword[esp + 4], rmode
    call fopen
    
    mov dword[f], eax
    
.L:
    mov edx, dword[f]
    mov dword[esp], edx
    mov dword[esp + 4], msg
    mov dword[esp + 8], temp
    call fscanf
    
    cmp eax, -1
    je .EL
    
    mov edx, dword[temp]
    add dword[res], edx
    adc dword[res + 4], 0
    jmp .L
.EL:
    mov edx, dword[f]
    mov dword[esp], edx
    call fclose
    
    mov dword[esp], fout
    mov dword[esp + 4], wmode
    call fopen
    
    mov dword[f], eax
    
    mov dword[esp], eax
    mov dword[esp + 4], msgl
    mov edx, dword[res]
    mov dword[esp + 8], edx
    mov edx, dword[res + 4]
    mov dword[esp + 12], edx
    call fprintf
    
    mov edx, dword[f]
    mov dword[esp], edx
    call fclose
    
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret