%include "io.inc"

section .rodata
    ;fin db `/home/boris/prak/asm/input22.bin`, 0
    ;fout db `/home/boris/prak/asm/output22.bin`, 0
    fin db `input.bin`, 0
    fout db `output.bin`, 0
    rmode db `rb`, 0
    wmode db `wb`, 0
section .bss
    a resd 1000000
    f resd 1
    ans resd 1
    n resd 1
    x resd 1
    f1 resd 1
    f2 resd 2
    
CEXTERN fread
CEXTERN fwrite
CEXTERN fopen
CEXTERN fclose
    

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    and esp, ~15
    sub esp, 16
    
    mov dword[f1], 1
    mov dword[f2], 1
    
    mov dword[esp], fin
    mov dword[esp + 4], rmode
    call fopen
    
    mov dword[f], eax

    
.L:
    mov dword[esp], x 
    mov dword[esp + 4], 4
    mov dword[esp + 8], 1
    mov edx, dword[f]
    mov dword[esp + 12], edx
    call fread
    test eax, eax
    je .EL

    mov ecx, dword[n]
    mov edx, dword[x]
    mov dword[a + 4 * ecx], edx
    inc dword[n]
    jmp .L      
    
.EL:    
    mov edx, dword[f]
    mov dword[esp], edx
    call fclose
    
    xor edi, edi
.L1:
    mov esi, edi
    sal esi, 1
    inc esi
    cmp esi, dword[n]
    jge .EL1
    mov edx, dword[a + 4 * edi]
    cmp edx, dword[a + 8 * edi + 4]
    jl .f1
    mov esi, edi
    sal esi, 1
    add esi, 2
    cmp esi, dword[n]
    jge .skip
    cmp edx, dword[a + 8 * edi + 8]
    jl .f1
.skip:   
    inc edi 
    jmp .L1
.f1:
    mov dword[f1], 0            
.EL1:                
    xor edi, edi
.L2:
    mov esi, edi
    sal esi, 1
    inc esi
    cmp esi, dword[n]
    jge .EL2
    mov edx, dword[a + 4 * edi]
    cmp edx, dword[a + 8 * edi + 4]
    jg .f2
    mov esi, edi
    sal esi, 1
    add esi, 2
    cmp esi, dword[n]
    jge .skip1
    cmp edx, dword[a + 8 * edi + 8]
    jg .f2   
.skip1:
    inc edi
    jmp .L2 
.f2:
    mov dword[f2], 0       
.EL2:                
    mov edx, dword[f1]
    mov ecx, dword[f2]
    
    test edx, edx
    jne .next
    test ecx, ecx
    jne .next
    mov dword[ans], 0
    jmp .out
.next:
    cmp dword[f2], 1
    jne .next1
    mov dword[ans], 1
    jmp .out
.next1:
    cmp dword[f1], 1
    jne .out
    mov dword[ans], -1
.out:

    mov dword[esp], fout
    mov dword[esp + 4], wmode
    call fopen

    mov dword[f], eax

    mov dword[esp], ans
    mov dword[esp + 4], 4
    mov dword[esp + 8], 1
    mov edx, dword[f]
    mov dword[esp + 12], edx
    call fwrite
    mov edx, dword[f]
    mov dword[esp], edx
    call fclose
                            
    

    mov esp, ebp
    pop ebp
    xor eax, eax
    ret