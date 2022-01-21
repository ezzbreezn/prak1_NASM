%include "io.inc"

section .rodata
    msg db `%d`, 0
    fin db `data.in`, 0
    rmode db `rb`, 0
    
CEXTERN fopen
CEXTERN fclose
CEXTERN printf
;CEXTERN fread
CEXTERN fscanf

section .bss
    x resd 1
    f resd 1    
    num resd 1
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
   ; mov dword[esp], x
   ; mov dword[esp + 4], 4
   ; mov dword[esp + 8], 1
   ; mov edx, dword[f]
   ; mov dword[esp + 12], edx
   ; call fread
   ; test eax, eax
   ; je .EL
   ; inc dword[num]
   ; jmp .L
        
   mov edx, dword[f]
   mov dword[esp], edx
   mov dword[esp + 4], msg
   mov dword[esp + 8], x
   call fscanf
   cmp eax, -1
   je .EL
   inc dword[num]
   jmp .L     
.EL:    

    mov edx, dword[f]
    mov dword[esp], edx
    call fclose
    
    mov dword[esp], msg
    mov edx, dword[num]
    mov dword[esp + 4], edx
    call printf                                        
    
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret