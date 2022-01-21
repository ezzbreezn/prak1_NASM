%include "io.inc"

section .rodata
    msgi db `%d`, 0
    msgo db `%lld`, 0
    msgoo db `%d `, 0
    sn db `\n`, 0
section .data
    size dd 10000000
    sd dd 10000000 
    mask dd 0x80000000 
    
section .bss
    arr resd 1
    dim resd 1
    n resd 1
    temp resd 2
    c resd 1
    ms resd 1
    md resd 1
    
    
    s1 resd 1
    s2 resd 1
    mtr resd 2
    
CEXTERN scanf
CEXTERN printf
CEXTERN malloc
CEXTERN free
CEXTERN realloc
            
    

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    
    mov dword[esp], msgi
    mov dword[esp + 4], n
    call scanf
    
    mov eax, dword[n]
    mov dword[sd], eax
    
    mov ecx, dword[size]
    sal ecx, 2
    mov dword[esp], ecx
    call malloc
    mov dword[arr], eax
    
    mov ecx, dword[sd]
    sal ecx, 2
    mov dword[esp], ecx
    call malloc
    mov dword[dim], eax
    
    xor edi, edi
    xor esi, esi
.I:
    cmp edi, dword[n]
    je .EI
    
    ;cmp edi, dword[sd]
    ;jl .n1
    ;mov ecx, dword[sd]
    ;sal ecx, 1
    ;mov dword[sd], ecx
    ;mov dword[esp + 4], ecx
    ;mov ecx, dword[dim]
    ;mov dword[esp], ecx
    ;call realloc
    ;mov dword[dim], eax
   
.n1:    
    mov ecx, dword[dim]
    lea edx, [ecx+ 4 * edi]
    mov dword[esp], msgi
    mov dword[esp + 4], edx
    call scanf


    mov ecx, dword[dim]
    mov eax, dword[ecx + 4 * edi]
    mul dword[ecx + 4 * edi]
    mov dword[temp], eax
    ;PRINT_DEC 4, eax
    ;NEWLINE
.MI:
    cmp dword[temp], 0
    je .EMI
    cmp esi, dword[size]
    jl .n2
    mov ecx, dword[size]
    sal ecx, 1
    mov dword[size], ecx
    mov dword[esp + 4], ecx
    mov ecx, dword[arr]
    mov dword[esp], ecx
    call realloc
    mov dword[arr], eax
.n2:    
    mov dword[esp], msgi
    mov ecx, dword[arr]
    lea edx, [ecx + 4 * esi]
    mov dword[esp + 4], edx
    call scanf
    inc esi
    dec dword[temp]
    jmp .MI
.EMI:            
    inc edi
    jmp .I    
.EI:    
    
    mov dword[s1], esi
    mov dword[s2], edi
    ;PRINT_DEC 4, [s1]
    ;NEWLINE
    ;PRINT_DEC 4, [s2]
    ;NEWLINE
    
    xor edi, edi
    xor esi, esi
    
.T:
    cmp edi, dword[n]
    je .ET
    mov ecx, dword[dim]
    mov ebx, dword[ecx + 4 * edi]
    xor ecx, ecx
    mov dword[temp], 0
    mov dword[temp + 4], 0
.ST:
    cmp ecx, ebx
    je .EST
    ;mov edx, dword[arr]
    mov eax, ecx
    mul ebx
    add eax, ecx
    add eax, esi
    push ecx
    mov edx, dword[arr]
    mov ecx, dword[edx + 4 * eax]
    mov eax, ecx
    cdq
    add dword[temp], eax
    adc dword[temp + 4], 0
    add dword[temp + 4], edx

    pop ecx
    inc ecx
    
    
    jmp .ST
            
.EST: 
    ;PRINT_DEC 4, [temp + 4]
    ;NEWLINE
    ;PRINT_DEC 4, [temp]
    ;NEWLINE
    
       ; mov dword[esp], msgo
    ;mov eax, dword[temp]
    ;mov dword[esp + 4], eax
    ;mov eax, dword[temp + 4]
    ;mov dword[esp + 8], eax
    ;call printf
    
    ;mov dword[esp], sn
    ;call printf
    
    
    
    mov eax, dword[temp + 4]
    mov edx, dword[mtr + 4]
    cmp eax, 0
    jl .ng1
    cmp edx, 0
    jl .rw
    
    cmp eax, edx       
    ;mov eax, dword[temp]
    ;cmp eax, dword[mtr]
    jl .skip
    jg .rw
    mov eax, dword[temp]
    ;PRINT_DEC 4, eax
    ;NEWLINE
    
    mov edx, dword[mtr]
    ;PRINT_DEC 4, edx
    ;NEWLINE
    cmp eax, edx
    ;jl .skip
    jb .skip
    ;jg .rw
    ja .rw
    cmp dword[md], 0
    je .rw
    jmp .skip
.ng1:
    cmp edx, 0
    jge .check
    cmp eax, edx       
    ;mov eax, dword[temp]
    ;cmp eax, dword[mtr]
    jb .skip
    ja .rw
    mov eax, dword[temp]
    mov edx, dword[mtr]
    cmp eax, edx
    jb .skip
    ja .rw
    cmp dword[md], 0
    je .rw
    jmp .skip    
    
    
.rw:    
    mov eax, dword[temp]
    mov dword[mtr], eax
    mov eax, dword[temp + 4]
    mov dword[mtr + 4], eax
    mov dword[md], ebx
    mov dword[ms], esi
.check:
    cmp dword[md], 0
    je .rw
    jmp .skip 
        
.skip:    
    inc ecx
    mov eax, ebx
    mul ebx
    add esi, eax
    inc edi
    
           ; mov dword[esp], msgo
    ;mov eax, dword[temp]
    ;mov dword[esp + 4], eax
    ;mov eax, dword[temp + 4]
    ;mov dword[esp + 8], eax
    ;call printf
    
    ;mov dword[esp], sn
    ;call printf
    
    
    
    jmp .T
    
.ET: 
    ;PRINT_DEC 4, [md]
    ;NEWLINE
    ;PRINT_DEC 4, [ms]
    ;NEWLINE
    ;PRINT_DEC 4, [mtr]
    
    ;mov ebx, dword[md]
    

    
    
    
    cmp dword[md], 0
    jne .f
    mov ecx, dword[dim]
    mov ecx, dword[ecx]
    mov dword[md], ecx 
.f:    
    mov esi, dword[ms]
    ;mov edi, dword[arr]
    ;mov esi, dword[edi + 4 * esi]
    ;mov edi, dword[md]
    xor ebx, ebx
.O:
    cmp ebx, dword[md]
    je .EO
    xor edi, edi
.OO:
    cmp edi, dword[md]
    je .EOO
    mov dword[esp], msgoo
    mov edx, dword[arr]
    mov edx, dword[edx + 4 * esi]
    mov dword[esp + 4], edx
    call printf
    inc esi
    inc edi
    jmp .OO
.EOO:            
    mov dword[esp], sn
    call printf
    inc ebx
    jmp .O    
                
.EO:         
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret