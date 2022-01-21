%include "io.inc"

section .rodata
    msg db `%s`, 0
    msgd db `%d`, 0
    
CEXTERN scanf
CEXTERN printf
CEXTERN strlen

section .bss
    s1 resb 1002
    s2 resb 1002
    
section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msg
    mov dword[esp + 4], s1
    call scanf
    
    
    mov dword[esp], msg
    mov dword[esp + 4], s2
    call scanf
    
    mov dword[esp], s1
    mov dword[esp + 4], s2
    call STRPFX
;    test eax, eax
;    je .op
;    inc eax
;.op:
    mov dword[esp], msgd
    mov dword[esp + 4], eax
    call printf
    
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
    
STRPFX:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    mov edi, dword[ebp + 8]
    mov esi, dword[ebp + 12]
    
    
    mov dword[esp], edi
    call strlen
    
    mov dword[esp + 12], eax
    
    mov dword[esp], esi
    call strlen
    
    cmp eax, dword[esp + 12]
    jge .skip
    mov dword[esp + 12], eax
.skip:    
    xor ecx, ecx
.L:
    cmp ecx, dword[esp + 12]
    je .EL
    mov al, byte[edi +  ecx]
    mov dl, byte[esi + ecx]
    cmp al, dl
    jne .EL
    inc ecx
    jmp .L
    
.EL:  
    
    mov eax, ecx      
    mov esp, ebp
    sub esp, 8
    pop edi
    pop edi
    pop ebp
    ret    