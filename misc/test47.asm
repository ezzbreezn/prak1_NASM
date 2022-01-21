%include "/usr/share/sasm/include/io64.inc"

section .bss
    x resd 30

section .text
global CMAIN
CMAIN:
    ;mov ecx, 10
    ;mov ebx, 10
    
;PRINT:
    ;mov eax, ecx
    ;cdq
    ;idiv ebx
    ;cmp eax, edx
    ;je SKIP
    ;PRINT_DEC 4, ecx
    ;NEWLINE
;SKIP:
    ;inc ecx
    ;cmp ecx, 100
    ;jl PRINT
    
    ;GET_DEC 4, [x]
    ;mov eax, dword[x]
    ;mov ecx, 10
    ;xor ebx, ebx
;DIVISION:
    ;cdq
    ;idiv ecx
    ;add ebx, edx
    ;test eax, eax
    ;jne DIVISION
    
    ;PRINT_DEC 4, ebx
    ;NEWLINE
    
    
    ;GET_DEC 4, [x]
    ;mov eax, 1
    ;mov ebx, 1
    ;mov ecx, 1
    ;cmp dword[x], 1
    ;je STOPFIB
    ;mov ecx, 2
    ;PRINT_DEC 4, eax
    ;NEWLINE
    ;PRINT_DEC 4, ebx
    ;NEWLINE
    ;PRINT_DEC 4, ecx
    ;NEWLINE
    
;FIB:
    ;cmp ecx, dword[x]
    ;jge STOPFIB
    ;mov eax, ebx
    ;mov ebx, ecx
    ;add ecx, eax
    ;PRINT_DEC 4, ecx
    ;NEWLINE
    ;jmp FIB
    
;STOPFIB:
    ;NEWLINE
    ;PRINT_DEC 4, ecx
    ;NEWLINE
    
    mov eax, x
    mov ecx, 30
INPUT:
    GET_DEC 4, [eax]
    add eax, 4
    loop INPUT
    
    mov eax, dword[x]
    mov edx, 1
    mov ecx, 29
    mov ebx, x + 4
    
FM:
    cmp eax, dword[ebx]
    jnl CONT1
    mov eax, dword[ebx]
    mov edx, 1
    jmp CONT2
CONT1:
    jne CONT2
    inc edx
CONT2:
    add ebx, 4
    loop FM
    
    PRINT_DEC 4, eax
    NEWLINE
    PRINT_DEC 4, edx
    NEWLINE
    
    xor rax, rax
    ret