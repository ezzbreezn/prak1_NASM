%include "io.inc"

section .rodata
    msg db `%d`, 0
    msgd db `%d%d`, 0
    msgo db `%d %d\n`, 0
    
section .bss
    a resd 1
    n resd 1
    
CEXTERN scanf
CEXTERN printf
CEXTERN malloc
CEXTERN free            

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msg
    mov dword[esp + 4], n
    call scanf
    
    mov esi, dword[n]
.L:
    test esi, esi
    je .EL
    cmp esi, dword[n]
    jne .next
    call F
    mov dword[a], eax
    mov edi, dword[a]
    jmp .ni
.next:                    
    call F
    mov dword[edi + 8], eax
    mov edi, dword[edi + 8]
    
    
.ni:
    dec esi
    jmp .L    
;    mov dword[esp], 12
;    call malloc
;    
;    mov dword[a], eax
;    
;    mov esi, dword[a]
;    xor edi, edi
;.L:
;    cmp edi, dword[n]
;    je .EL
;    
;    mov dword[esp], msgd
;    mov dword[esp + 4], esi
;    lea edx, [esi + 4]
;    mov dword[esp + 8], edx
;    call scanf
    
;    inc edi
;    cmp edi, dword[n]
;    je .EL   
;    mov dword[esp], 12
;    call malloc
;    mov dword[esi + 8], eax
;    mov esi, dword[esi + 8]
;    jmp .L
    
;.EL:  
.EL:  
    push dword[a]
    call PRINT
    add esp, 4

    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    xor eax, eax
    ret
    
F:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], 12
    call malloc
    
    mov edi, eax
    
    mov dword[esp], msgd
    mov dword[esp + 4], edi
    lea edx, [edi + 4]
    mov dword[esp + 8], edx
    call scanf
    
    mov eax, edi
            
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    ret 
    
PRINT:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    cmp dword[ebp + 8], 0
    je .out
    
    mov eax, dword[ebp + 8]
    
    mov dword[esp], msgo
    mov edx, dword[eax]
    mov dword[esp + 4], edx
    mov edx, dword[eax + 4]
    mov dword[esp + 8], edx
    call printf
    
    mov eax, dword[ebp + 8]
    mov eax, dword[eax + 8]
    mov dword[esp], eax
    call PRINT
        
              
.out:        
    mov esp, ebp
    pop ebp
    ret          