%include "io.inc"

section .bss
    a resd 1

section .data
    x dw 0xfedc, 0xba98
    y dw 0x7654, 0x3210
    
    

section .text
global CMAIN
CMAIN:
    ;write your code here
    movsx eax, word[y-1]
    rol eax, 12
    PRINT_HEX 4, eax
    NEWLINE
    mov ah, 0xcd
    xchg al, byte[y+1]
    PRINT_HEX 4, eax
    NEWLINE
    btc eax, 14
    adc eax, 1
    PRINT_HEX 4, eax
    NEWLINE
    ret