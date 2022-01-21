%include "io.inc"

section .bss
    n resd 1
    k resd 1
    p resd 1
    s resd 1
    sc resd 1
    
section .data
    ;preans dd 0
    ans dd 0
    finans dd 0

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, [n]
    GET_UDEC 4, [k]
    mov eax, dword[n]
    mov ecx, 0
    mov ebx, 1
    
.CHECK:
    test eax, eax
    je .STOPCHECK
    test ebx, eax
    jne .SKIP
    inc ecx
.SKIP:
    shr eax, 1
    jmp .CHECK
.STOPCHECK:
    cmp ecx, dword[k]
    jne .SKIP1
    inc dword[finans]
.SKIP1:
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
    cmp ecx, dword[k]
    jl .PRINT
.CONT:
    mov ebx, 1
    shl ebx, cl
    shr ebx, 1
    mov dword[sc], ecx
    dec dword[sc]
.SECONE:
    test ebx, ebx
    je .ENDSEC
    test ebx, dword[n]
    jne .ENDSEC
    dec dword[sc]
    shr ebx, 1
    jmp .SECONE
.ENDSEC:
    cmp dword[sc], -1
    je .LCNT
    cmp dword[sc], 0
    jne .CSEC
    inc dword[finans]
    jmp .LCNT
.CSEC:
    PRINT_DEC 4, [sc]
    NEWLINE
    

;----------------------------------------------------
    mov ebx, 1
    shl ebx, cl
.MAINLOOP:
    cmp dword[k], 0
    je .ENDLOOP
    test ebx, ebx
    je .ENDLOOP
    test ecx, ecx
    je .ENDLOOP
    test ebx, dword[n]
    jne .CNT
    dec dword[k]
    shr ebx, 1
    dec ecx
    jmp .MAINLOOP
.CNT:
    mov dword[s], 1
    mov edi, dword[k]
    dec edi
    cmp edi, 0
    je .RESPROC
    mov edi, 1
    mov esi, ecx
    add esi, 2
    sub esi, dword[k]
.CNTLOOP:
    cmp edi, dword[k]
    jg .RESPROC
    mov eax, dword[s]
    xor edx, edx
    mul esi
    div edi
    mov dword[s], eax
    inc edi
    inc esi
    jmp .CNTLOOP
.RESPROC:
    mov eax, dword[s]
    PRINT_DEC 4, eax
    NEWLINE
    add dword[ans], eax
    dec ecx
    jmp .MAINLOOP
    
.ENDLOOP:
    
    
    
     
        

.PRINT:
    mov eax, dword[ans]
    add dword[finans], eax
    PRINT_UDEC 4, [finans]
.FIN:
    xor eax, eax
    ret