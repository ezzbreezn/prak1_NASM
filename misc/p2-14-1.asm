%include "io.inc"

section .bss
    n resd 1
    k resd 1
    p resd 1
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
.FIRSTONE:
    test eax, eax
    je .out
    inc ecx
    shr eax, 1
    jmp .FIRSTONE
    
.out:
    dec ecx
    
    cmp dword[k], 0
    jne .CONT
    PRINT_UDEC 4, ecx
    jmp .FIN
.CONT:
    dec ecx
;-------------------leftover count-------------------
    mov ebx, 1
    shl ebx, cl
    shl ebx, 1
    dec ebx
    
    
    mov eax, dword[n]
.L0:
    cmp eax, ebx
    jle .EL0
    xor esi, esi
    mov edi, eax
.L00:

    test edi, 1
    jnz .GO
    inc esi
.GO:
    shr edi, 1
    test edi, edi
    jne .L00
    
    cmp esi, dword[k]
    jne .N
    inc dword[preans]
.N:
    dec eax
    jmp .L0
    
    
.EL0:
    cmp dword[k], ecx
    jg .PRINT
   
;---------------end of leftover count-----------

;---------------last combinations------------------
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
    
;------------------end of last combinations---------------
.PRINT:
    mov eax, dword[preans]
    add dword[finans], eax
    mov eax, dword[ans]
    add dword[finans], eax
    PRINT_UDEC 4, [finans]
.FIN:
    xor eax, eax
    ret