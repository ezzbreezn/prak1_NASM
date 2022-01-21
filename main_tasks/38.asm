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
.skip1:
    mov dword[esp], msgd
    mov dword[esp + 4], temp
    call scanf
    
    cmp dword[temp], 1
    jne .skip2
    mov edx, edi
    lea edx, [edx + 2 * edx]
    sal edx, 3
    bts dword[esi + edx], 30
.skip2:    
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

    mov esi, dword[arr]
    xor edi, edi
.P:
    cmp edi, dword[n]
    je .EP
    
    mov edx, edi
    lea edx, [edx + 2 * edx]
    sal edx, 3
    
    bt dword[esi + edx], 31
    je .z1
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
    je .z2
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
    finit
    
    fld qword[edx]
    fld qword[ecx]
    fucomip
    ja .L1
    jb .L2
    xor eax, eax
    jmp .out
.L1:
    mov eax, 1
    jmp .out    
.L2:    
    mov eax, -1
    jmp .out
.out:    
    mov esp, ebp
    pop ebp 
    ret