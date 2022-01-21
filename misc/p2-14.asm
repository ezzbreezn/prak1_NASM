%include "io.inc"

section .bss
    n resd 1
    k resd 1
    p resd 1
    s resd 1
    temp resd 1

section .data
    preans dd 0
    ans dd 0
    finans dd 0

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, [n]
    GET_UDEC 4, [k]
    mov eax, dword[n]
    mov ecx, 0
    
    
.L:
    test eax, eax
    je .out
    inc ecx
    shr eax, 1
    jmp .L
    
.out:
    PRINT_DEC 4, ecx
    NEWLINE
    dec ecx
    
    cmp dword[k], 0
    jne .CONT
    PRINT_UDEC 4, ecx
    jmp .FIN
.CONT:
    
    mov edx, ecx
    dec ecx
    mov ebx, 1
    shl ebx, cl
    mov ecx, edx
    xor eax, eax
.F:
    test ebx, ebx
    je .EP
    test dword[n], ebx
    je .NF
    inc eax
.NF:
    shr ebx, 1
    jmp .F
    
    cmp eax, dword[k]
    jne .GN
    add dword[finans], 1
    
.GN:
    dec ecx
    mov edx, 1
    shl edx, cl
    mov dword[s], ecx
.P:
    test edx, edx
    je .EP
    test dword[n], edx
    jne .EP
    shr edx, 1
    test edx, edx
    ;je .EP
    dec dword[s]
    jmp .P
    
.EP:

    ;PRINT_DEC 4, [s]
    ;NEWLINE
    
;------------------ALL ABOVE OK--------------------

    PRINT_DEC 4, ecx
    NEWLINE
    PRINT_DEC 4, [s]
    NEWLINE
    cmp dword[s], -1
    
    mov edx, dword[k]
    add edx, dword[s]
    sub edx, ecx
    inc dword[s]
    cmp dword[s], edx
    jl .NEXT
    jg .N
    mov dword[preans], 1
    jmp .NEXT

.N:
    mov esi, dword[s]
    sub esi, edx
    inc esi
    mov ebx, 1
    mov edi, edx
    inc edi
    mov dword[preans], 1
    
.PL:
    cmp ebx, edi
    jg .NEXT
    mov eax, dword[preans]
    xor edx, edx
    mul esi
    div ebx
    mov dword[preans], eax
    inc ebx
    inc esi
    jmp .PL
    

;    dec ecx
;    
;    mov ebx, 1
;    shl ebx, cl
;    shl ebx, 1
;    dec ebx
    

;    mov eax, dword[n]

;.L0:
;    cmp eax, ebx
;    jle .EL0
;    xor esi, esi
;    mov edi, eax
;.L00:

;    test edi, 1
;    jnz .GO
;    inc esi
;.GO:
;    shr edi, 1
;    test edi, edi
;    jne .L00
    
;    cmp esi, dword[k]
;    jne .N
;    inc dword[preans]
;.N:
;    dec eax
;    jmp .L0
    
    
;.EL0:
    
    
;----------ALL OK----------------    
.NEXT:
    cmp dword[k], ecx
    jg .PRINT
    

    mov dword[p], ecx
    
    mov ecx, dword[p]
    mov ebx, 1
    add ecx, 1
    sub ecx, dword[k]
    add dword[k], 1
    mov dword[ans], 1
.L1:
    cmp ebx, dword[k]
    jg .PRINT
    mov eax, dword[ans]
    xor edx, edx
    mul ecx
    div ebx
    mov dword[ans], eax
    inc ebx
    inc ecx
    jmp .L1
;.BL:
;    mov ecx, dword[p]
;    mov ebx, 1
;    sub ecx, dword[k]
;    inc ecx
;    mov dword[ans], 1
;.L1:
;    cmp ebx, dword[k]
;    jg .SBL
;    mov eax, dword[ans]
;    xor edx, edx
;    mul ecx
;    ;xor edx, edx
;    div ebx
;    mov dword[ans], eax
;    inc ebx
;    inc ecx
;    jmp .L1
    
;.SBL:
;    mov eax, dword[ans]
;    add dword[finans], eax
;    dec dword[p]
;    mov eax, dword[p]
;    cmp eax, dword[k]
;    jnl .BL
    
    
.PRINT:
    PRINT_DEC 4, [preans]
    NEWLINE
    PRINT_DEC 4, [ans]
    NEWLINE
    mov eax, dword[preans]
    add dword[finans], eax
    mov eax, dword[ans]
    add dword[finans], eax
    PRINT_UDEC 4, [finans]
.FIN:
    xor eax, eax
    ret