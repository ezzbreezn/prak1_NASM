%include "io.inc"

section .bss
    a resd 1
    b resd 1
    c resd 1
    adec resd 7
    bdec resd 7
    cdec resd 7
    res resd 7
    tres resd 7
    alen resd 1
    blen resd 1
    clen resd 1
    extra resd 1
    temp resd 1
    mlen resd 1
    tlen resd 1
    
section .data
    mod dd 10000
    sign dd 1
    
section .text
global CMAIN
CMAIN:
    GET_DEC 4, [a]
    cmp dword[a], 0
    jge .next1
    neg dword[a]
    neg dword[sign]
.next1:
    GET_DEC 4, [b]
    cmp dword[b], 0
    jge .next2
    neg dword[b]
    neg dword[sign]
.next2:
    GET_DEC 4, [c]
    cmp dword[c], 0
    jge .next3
    neg dword[c]
    neg dword[sign]
.next3:
    push alen
    push adec
    push dword[a]
    call TODEC
    add esp, 12
    push blen
    push bdec
    push dword[b]
    call TODEC
    add esp, 12
    push clen
    push cdec
    push dword[c]
    call TODEC
    add esp, 12
    
    
    push dword[blen]
    push dword[alen]
    push bdec
    push adec
    call LMUL
    add esp, 16
    
    mov eax, dword[mlen]
    mov dword[tlen], eax
    
    
    xor ecx, ecx
    
.COPY:
    cmp ecx, dword[mlen]
    je .ECOPY
    mov eax, dword[res + 4 * ecx]
    mov dword[tres + 4 * ecx], eax
    mov dword[res + 4 * ecx], 0
    inc ecx
    jmp .COPY
.ECOPY:
    
    push dword[clen]
    push dword[tlen]
    push cdec
    push tres
    call LMUL
    add esp, 16
    push res
    push dword[mlen]
    call PRINT
    add esp, 8
 
    xor eax, eax
    ret
    
TODEC:
    push ebp
    mov ebp, esp
    push ebx
    push edi
    mov eax, dword[ebp + 8]
    mov ebx, dword[ebp + 12]
    mov edi, dword[ebp + 16]
    xor ecx, ecx
    
.L:
    test eax, eax
    je .EL
    xor edx, edx
    div dword[mod]
    mov dword[ebx + 4 * ecx], edx
    inc ecx
    jmp .L
    
.EL:
    mov dword[edi], ecx
    xor eax, eax
    pop edi
    pop ebx
    mov esp, ebp
    pop ebp
    ret

LMUL:
    push ebp
    mov ebp, esp
    push ebx
    push edi
    push esi
    mov edi, dword[ebp + 8] 
    mov esi, dword[ebp + 12]
    xor ecx, ecx
    
.L:
    cmp ecx, dword[ebp + 20] ;len b
    je .EL
    xor ebx, ebx
.LL:
    cmp ebx, dword[ebp + 16] ;len a
    je .ELL
    mov eax, dword[edi + 4 * ebx]

    xor edx, edx
    mul dword[esi + 4 * ecx]


    add eax, dword[extra]
    mov edx, ecx
    add edx, ebx
    inc edx
    cmp edx, dword[mlen]
    jle .next
    mov dword[mlen], edx
.next:
    dec edx
    add eax, dword[res + 4 * edx]
    mov dword[temp], edx
    xor edx, edx
    div dword[mod]
    mov dword[extra], eax
    mov eax, edx
    mov edx, dword[temp]
    mov dword[res + 4 * edx], eax
    
    
    inc ebx
    cmp ebx, dword[ebp + 16]
    jne .skip1
    cmp dword[extra], 0
    je .skip1
    inc edx
    push ecx
    mov ecx, dword[extra]
    add dword[res + 4 * edx], ecx
    inc dword[mlen]
    mov dword[extra], 0
    pop ecx
.skip1:
    jmp .LL

.ELL:
    inc ecx
    jmp .L
.EL:
    pop esi
    pop edi
    pop ebx
    mov esp, ebp
    pop ebp
    ret

PRINT:
    push ebp
    mov ebp, esp
    mov eax, dword[ebp + 12]
    mov ecx, dword[ebp + 8]
    cmp dword[sign], -1
    jne .L
    PRINT_CHAR '-'
.L:
    test ecx, ecx
    je .EL
    cmp ecx, dword[ebp + 8]
    je .F
    mov edx, dword[eax + 4 * ecx - 4]
    cmp edx, 10
    jge .next1
    PRINT_STRING '000'
    jmp .F
.next1:
    cmp edx, 100
    jge .next2
    PRINT_STRING '00'
    jmp .F
.next2:
    cmp edx, 1000
    jge .F
    PRINT_CHAR '0'
    jmp .F
.F:
    PRINT_DEC 4, [eax + 4 * ecx - 4]
    dec ecx
    jmp .L
.EL:
    NEWLINE
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret