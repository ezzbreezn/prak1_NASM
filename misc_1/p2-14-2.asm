%include "io.inc"

section .bss
    n resd 1
    k resd 1
    kn resd 1
    p resd 1
    s resd 1
    sc resd 1
    kk resd 1
    
section .data
    ans dd 0
    finans dd 0

section .text
global CMAIN
CMAIN:
    
    GET_UDEC 4, [n]
    GET_UDEC 4, [k]
    mov eax, dword[k]
    mov dword[kn], eax
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
    mov dword[p], ecx

    cmp dword[k], 0
    jne .CONT
    PRINT_UDEC 4, ecx
    jmp .FIN
.CONT:
    cmp ecx, dword[k]
    jnl .CONT1
    PRINT_DEC 4, [finans]
    NEWLINE
    jmp .FIN
 
.CONT1:

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
    je .LCONT
    cmp dword[sc], 0
    jne .PRECONT
    inc dword[finans]
    jmp .LCONT
.PRECONT:
    mov edx, ecx
    mov ecx, dword[sc]
    mov ebx, 1
    shl ebx, cl
    sub edx, dword[sc]
    dec edx
    sub dword[k], edx
.MAINLOOP:
    test ebx, ebx
    je .ENDLOOP
    cmp dword[k], 0
    jle .ENDLOOP
    test ebx, dword[n]
    jne .CNT
    dec dword[k]
    shr ebx, 1
    dec ecx
    jmp .MAINLOOP
.CNT:
    mov dword[s], 1
    mov edi, dword[k]
    mov dword[kk], edi
    dec dword[kk]
    cmp dword[kk], ecx
    jg .ENDLOOP
    cmp dword[kk], 0
    je .RESPROC
    mov edi, 1
    mov esi, ecx
    add esi, 2
    sub esi, dword[k]
.CNTLOOP:
    cmp edi, dword[kk]
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
    add dword[ans], eax
    shr ebx, 1
    dec ecx
    jmp .MAINLOOP
    
.ENDLOOP:
    mov eax, dword[ans]
    add dword[finans], eax
.LCONT:
    mov dword[ans], 0
    
    dec dword[p]
    mov ebx, dword[kn]
    cmp ebx, dword[p]
    jg .PRINT
    mov dword[ans], 1
    mov ebx, 1
    mov ecx, dword[p]
    inc ecx
    sub ecx, dword[kn]
    inc dword[kn]
.LST:
    cmp ebx, dword[kn]
    jg .PRINT
    mov eax, dword[ans]
    xor edx, edx
    mul ecx
    div ebx
    mov dword[ans], eax
    inc ecx
    inc ebx
    jmp .LST
    
    PRINT_DEC 4, [ans]
    NEWLINE

.PRINT:
    mov eax, dword[ans]
    add dword[finans], eax
    PRINT_UDEC 4, [finans]
.FIN:
    xor eax, eax
    ret