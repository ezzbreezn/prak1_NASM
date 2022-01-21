%include "io.inc"

section .rodata
    msgf db `%lf`, 0
    msgd db `%d`, 0
    msgfo db `%lf `, 0
    msgdo db `%d `,0
    nl db `\n`,0
    
    
CEXTERN scanf
CEXTERN printf
CEXTERN qsort
CEXTERN malloc
CEXTERN free


section .bss
    arr resd 1
    n resd 1
    temp resd 1

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    push edi
    push esi
    and esp, ~15
    sub esp, 16
    
    mov dword[esp], msgd
    mov dword[esp + 4], n
    call scanf
    
    mov edx, dword[n]
    lea edx, [edx + 2 * edx]
    sal edx, 3
    mov dword[esp], edx
    call malloc
    mov dword[arr], eax
    
    xor edi, edi
    mov esi, dword[arr]
.L:
    cmp edi, dword[n]
    je .EL
    
    mov dword[esp], msgd
    mov dword[esp + 4], temp
    call scanf
    
    cmp dword[temp], 1
    jne .skip1
    mov edx, edi
    lea edx, [edx + 2 * edx]
    sal edx, 3
    bts dword[esi + edx], 31
    jmp .n1
.skip1:
    mov edx, edi
    lea edx, [edx + 2 * edx]
    sal edx, 3
    btr dword[esi + edx], 31


.n1:
    mov dword[esp], msgd
    mov dword[esp + 4], temp
    call scanf
    
    cmp dword[temp], 1
    jne .skip2
    mov edx, edi
    lea edx, [edx + 2 * edx]
    sal edx, 3
    bts dword[esi + edx], 30
    jmp .n2
.skip2:  
    mov edx, edi
    lea edx, [edx + 2 * edx]
    sal edx, 3
    btr dword[esi + edx], 30
  
.n2:   
    mov dword[esp], msgf
    mov edx, edi
    lea edx, [edx + 2 * edx]
    sal edx, 3
    lea edx, [esi + edx + 8]
    mov dword[esp + 4], edx
    call scanf
       
    mov dword[esp], msgd
    mov edx, edi
    lea edx, [edx + 2 * edx]
    sal edx, 3
    lea edx, [esi + edx + 16]
    mov dword[esp + 4], edx
    call scanf
    
    inc edi
    jmp .L
    
.EL:    
    mov edx, dword[arr]
    mov dword[esp], edx
    mov edx, dword[n]
    mov dword[esp + 4], edx
    mov dword[esp + 8], 24
    mov dword[esp + 12], COMP
    call qsort
    
;-----------------------------------------------------------------------    
   mov esi, dword[arr]
    xor edi, edi
.P:
    cmp edi, dword[n]
    je .EP
    
    mov edx, edi
    lea edx, [edx + 2 * edx]
    sal edx, 3
    
    bt dword[esi + edx], 31
    jnc .z1
    mov dword[esp], msgdo
    mov dword[esp + 4], 1
    call printf
    jmp .sp
.z1:
    mov dword[esp], msgdo 
    mov dword[esp + 4], 0
    call printf
.sp:
    
    mov edx, edi
    lea edx, [edx + 2 * edx]
    sal edx, 3
    
    bt dword[esi + edx], 30
    jnc .z2
    mov dword[esp], msgdo
    mov dword[esp + 4], 1
    call printf
    jmp .ssp
.z2:
    mov dword[esp], msgdo
    mov dword[esp +4 ], 0
    call printf
.ssp:
    mov edx, edi
    lea edx, [edx + 2 * edx]
    sal edx, 3
    mov dword[esp], msgfo
    mov ecx, dword[esi + edx + 8]
    mov dword[esp + 4], ecx
    mov ecx, dword[esi + edx + 12]
    mov dword[esp + 8], ecx
    call printf
    
    mov edx, edi
    lea edx, [edx + 2 * edx]
    sal edx, 3
    mov dword[esp], msgdo
    mov ecx, dword[esi + edx + 16]
    mov dword[esp + 4], ecx
    call printf
    
    mov dword[esp], nl
    call printf
    
    inc edi
    jmp .P

.EP:
;-------------------------------------------------------------------  
  
  
    
    
    
    
    
    

    mov dword[esp], msgd
    mov dword[esp +4], temp
    call scanf
    
    mov edx, dword[arr]
    mov dword[esp], edx
    mov edx, dword[n]
    mov dword[esp + 4], edx
    mov edx, dword[temp]
    mov dword[esp + 8], edx
    call BINSEARCH
    
    
    lea eax, [eax + 2 * eax]
    sal eax, 3
    mov esi, dword[arr]
    bt dword[esi + eax], 30
    jnc .a0
    mov dword[esp], msgd
    mov dword[esp + 4], 1
    call printf
    jmp .ff
.a0:
    mov dword[esp], msgd
    mov dword[esp + 4], 0
    call printf
.ff:
    mov edx, dword[arr]
    mov dword[esp], edx
    call free


    mov esp, ebp
    sub esp, 8
    pop esi
    pop edi
    pop ebp
    xor eax, eax
    ret
    
    
    
COMP:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov ecx, dword[ebp + 8]
    mov edx, dword[ebp + 12]
    mov ecx, dword[ecx + 16]
    mov edx, dword[edx + 16]

    cmp ecx, edx
    jl .l
    jg .g
    xor eax, eax
    jmp .out
.l:
    mov eax, -1
    jmp .out
.g:
    mov eax, 1
    jmp .out    
    
.out:    
    mov esp, ebp
    pop ebp
    ret
    
    
BINSEARCH:
    push ebp
    mov ebp, esp
    push edi
    push esi
    push ebx
    and esp, ~15
    sub esp, 16
    
    mov esi, dword[ebp + 8]
    mov eax, -1
    mov ecx, dword[ebp + 12]
    
.L:
    mov ebx, ecx
    dec ebx
    ;PRINT_DEC 4, eax
    ;NEWLINE
    ;PRINT_DEC 4, ecx
    ;NEWLINE
    cmp eax, ebx
    jge .EL
    mov ebx, ecx
    add ebx, eax
    shr ebx, 1
    lea ebx, [ebx + 2 * ebx]
    sal ebx, 3
    mov ebx, dword[esi + ebx + 16]
    ;PRINT_DEC 4, [esi + ebx + 16]
    ;NEWLINE
    cmp ebx, dword[ebp + 16]
    jg .e
    je .ass
    mov ebx, eax
    add ebx, ecx
    shr ebx, 1
    mov eax, ebx
    jmp .ni
.ass:
    
    mov ebx, eax
    add ebx, ecx
    shr ebx, 1
    mov eax, ebx
    jmp .EEL
.e:
    mov ebx, eax
    add ebx, ecx
    shr ebx, 1
    mov ecx, ebx
.ni:
    jmp .L    
.EL:    
    mov eax, ecx
.EEL:
    mov esp, ebp
    sub esp, 12
    pop ebx
    pop esi
    pop edi
    pop ebp
    ret
    