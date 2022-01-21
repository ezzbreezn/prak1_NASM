%include "io.inc"

section .rodata
    msg db `%d`, 0
    msgo db `%d `, 0
    msgll db `%lld`, 0
    nl db `\n`, 0
    
CEXTERN scanf
CEXTERN printf
CEXTERN malloc
CEXTERN malloc
CEXTERN free


section .bss
    mtr resd 1
    sz resd 1
    n resd 1
    ts resd 1
    te resd 1
    rc resd 1
    mt resd 2
    tt resd 2
    mti resd 1
    

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    push edi
    push esi
    push ebx
    and esp, ~15
    sub esp, 32
    
    mov dword[esp], msg
    mov dword[esp +4 ], n
    call scanf

    mov edx, dword[n]
    sal edx, 2
    mov dword[esp], edx
    call malloc
    
    mov dword[mtr], eax
    
    mov edx, dword[n]
    sal edx, 2
    mov dword[esp], edx
    call malloc
    
    mov dword[sz], eax
    
    xor edi, edi
.L:
    cmp edi, dword[n]
    je .EL
    mov dword[esp], msg
    mov dword[esp +4 ], ts
    call scanf
    
    mov edx, dword[sz]
    mov ecx, dword[ts]
    mov dword[edx + 4 * edi], ecx
    
    mov ecx, dword[ts]
    sal ecx, 2
    mov dword[esp], ecx
    call malloc
    mov esi, eax
    
    
   
    xor ebx, ebx
.MA:
    cmp ebx, dword[ts]
    je .EMA
    mov ecx, dword[ts]
    sal ecx, 2
    mov dword[esp], ecx
    call malloc
    ;PRINT_DEC 4, eax
    ;NEWLINE
    mov dword[esi + 4 * ebx], eax
    inc ebx
    jmp .MA
    
.EMA:    
    mov edx, dword[mtr]
    mov dword[edx + 4 * edi], esi
    mov dword[tt], 0
    mov dword[tt + 4], 0
    mov dword[rc], 0
.IP:

    mov ecx, dword[rc]
    cmp ecx, dword[ts]
    je .EIP
    xor ebx, ebx
.IIP:
    cmp ebx, dword[ts]
    je .EIIP
    mov edx, dword[rc]
    mov edx, dword[esi + 4 * edx]
    lea edx, [edx + 4 * ebx]

    mov dword[esp + 4], edx
    mov dword[esp], msg
    call scanf
    cmp ebx, dword[rc]
    jne .skip
    mov ecx, dword[rc]
    mov ecx, dword[esi + 4 * ecx]
    mov ecx, dword[ecx + 4 * ebx]
    mov eax, ecx
    cdq
    add dword[tt], eax
    adc dword[tt + 4], 0
    add dword[tt + 4], edx
    ;add dword[tt], ecx
    ;adc dword[tt + 4], 0

.skip:    
    inc ebx
    jmp .IIP
.EIIP:    
    inc dword[rc]
    jmp .IP
.EIP:    
    mov ecx, dword[tt]
    ;PRINT_DEC 4, ecx
    ;NEWLINE
    mov dword[esp], ecx
    mov ecx, dword[tt + 4]
    mov dword[esp + 4], ecx
    mov ecx, dword[mt]
    mov dword[esp + 8], ecx
    mov ecx, dword[mt + 4]
    mov dword[esp + 12], ecx
    call COMPLONG
    ;PRINT_DEC 4, eax
    ;NEWLINE
    cmp eax, 1
    jne .ni
    mov ecx, dword[tt]
    mov dword[mt], ecx
    mov ecx, dword[tt + 4]
    mov dword[mt + 4], ecx
    mov dword[mti], edi
.ni:
    inc edi
    jmp .L
.EL:    
    ;PRINT_DEC 4, [mti]
    ;NEWLINE

    ;mov dword[esp], msgll
    ;mov ecx, dword[mt]
    ;mov dword[esp + 4], ecx
    ;mov ecx, dword[mt + 4]
    ;mov dword[esp + 8], ecx
    ;call printf
    ;mov dword[esp], nl
    ;call printf
    mov esi, dword[mtr]
    mov edx, dword[mti]
    mov esi, dword[esi + 4 * edx]
    
    mov ecx, dword[sz]
    mov ecx, dword[ecx + 4 * edx]
    mov dword[ts], ecx
    xor ebx, ebx 
.ANS:
    cmp ebx, dword[ts]
    je .EANS
    xor edi, edi
.IC:
    cmp edi, dword[ts]
    je .EIC
    mov edx, dword[esi + 4 * ebx]
    mov edx, dword[edx + 4 * edi]
    mov dword[esp + 4], edx
    mov dword[esp], msgo
    call printf
    inc edi
    jmp .IC
.EIC:    
    mov dword[esp], nl
    call printf
    inc ebx
    jmp .ANS
    
.EANS:
    

    mov esp, ebp
    sub esp, 12
    pop ebx
    pop esi
    pop edi
    pop ebp
    xor eax, eax
    ret
    
    
COMPLONG:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    mov ecx, dword[ebp + 8]
    mov edx, dword[ebp + 12]
    mov edi, dword[ebp + 16]
    mov esi, dword[ebp + 20]
    
    ;PRINT_UDEC 4, ecx
    ;NEWLINE
    ;PRINT_UDEC 4, edx
    ;NEWLINE
    ;PRINT_UDEC 4, edi
    ;NEWLINE
    ;PRINT_UDEC 4, edi
    ;NEWLINE
    
    
    cmp edx, 0
    jl .ng1
    cmp esi, 0
    jl .fst
    
    cmp edx, esi
    jl .snd
    jg .fst
    
    cmp ecx, edi
    jbe .snd
    ja .fst
.ng1:
    cmp esi, 0
    jge .snd
    cmp edx, esi
    jb .snd
    ja .fst
    cmp ecx, edi
    jbe .snd
    ja .fst
.fst:
    mov eax, 1
    jmp .out
.snd:
    xor eax, eax
            
.out:            
    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    ret    