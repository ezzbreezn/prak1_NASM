%include "io.inc"

section .rodata
    msgf db `%lf`, 0
    fin db `input.bin` ,0
    rmode db `rb`, 0
    msgo db `%.4lf`, 0
    
CEXTERN fopen
CEXTERN fclose
CEXTERN fread
CEXTERN printf

section .bss
    f resd 1
    r resd 2
    h resd 2
    
section .data
    g dq 9.8066

section .text
global CMAIN
CMAIN:
    ;write your code here
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], fin
    mov dword[esp+ 4], rmode
    call fopen
    
    mov dword[f], eax
    
    
    mov dword[esp], r
    mov dword[esp + 4], 8
    mov dword[esp + 8], 1
    mov edx, dword[f]
    mov dword[esp + 12], edx
    call fread
    
    mov dword[esp], h
    mov dword[esp + 4], 8
    mov dword[esp + 8], 1
    mov edx, dword[f]
    mov dword[esp + 12], edx
    call fread
    
    mov edx, dword[f]
    mov dword[esp], edx
    call fclose
    
    finit
    
    fld qword[r]
    fld qword[h]
    fmulp
    fld qword[g]
    fmulp
    fstp qword[esp + 4]
    mov dword[esp], msgo
    call printf
    
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret