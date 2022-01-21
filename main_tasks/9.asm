%include "io.inc"

section .rodata
    msg db `%d`, 0
    msgd db `%d%d`, 0
    msgo db `%d %d\n`, 0
    
section .bss
    a resd 1
    n resd 1
    tres resd 1
    ans resd 1
    
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
    
    mov dword[esp], msg
    mov dword[esp + 4], tres
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
.EL:  
;    push dword[a]
;    call PRINT
;    add esp, 4

    push dword[tres]
    push dword[a]
    push ans
    call G
    add esp, 12
    
    mov dword[esp], msgo
    mov edx, dword[ans]
    mov dword[esp + 4], edx
    mov edx, dword[ans + 4]
    mov dword[esp + 8], edx
    call printf
    
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
    
G:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov eax, dword[ebp + 8]
    
    mov edx, dword[ebp + 12]
.L:
    test edx, edx
    je .EL
    mov ecx, dword[edx]
    sub ecx, dword[edx + 4]
    cmp ecx, 0
    jge .skip
    neg ecx
.skip:    
    cmp ecx, dword[ebp + 16]
    jle .ni
    mov ecx, dword[edx]
    mov dword[eax], ecx
    mov ecx, dword[edx + 4]
    mov dword[eax + 4], ecx
    jmp .out
.ni:
    mov edx, dword[edx + 8]
    jmp .L 
.EL:              
    mov dword[eax], 0
    mov dword[eax + 4], 0
.out:                                                                    
    mov esp, ebp
    pop ebp
    ret                