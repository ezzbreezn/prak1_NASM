%include "io.inc"

section .rodata
    fin db `/home/boris/prak/asm/sassasm/input.bin`, 0
    rmode db `rb`, 0
    msg db `%02x `, 0
    nl db `\n` ,0
    
CEXTERN printf
CEXTERN fopen 
CEXTERN fclose
CEXTERN fread

section .bss
    f resd 1
    temp resb 1  

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], fin
    mov dword[esp +4], rmode
    call fopen
    mov dword[f], eax
    
    mov dword[esp], eax
    call PRINT
    
    
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
    
PRINT:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 32
    
    xor edi, edi
.L:
    mov edx, dword[ebp + 8]
    mov dword[esp + 12], edx
    mov dword[esp + 4], 1
    mov dword[esp + 8], 1
    lea edx, [esp + 16]
    mov dword[esp ], edx
    call fread
    
    test eax, eax
    je .EL
    
    mov dword[esp], msg
    movsx edx, byte[esp + 16]
    mov dword[esp + 4], edx
    call printf
    
    cmp edi, 16
    jne .skip
    mov dword[esp], nl
    call printf
.skip:    
    inc edi
    jmp .L
.EL:
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    ret