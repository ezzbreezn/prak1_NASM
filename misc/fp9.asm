%include "io.inc"

section .rodata
    msgi db `%d`, 0
    msgf db `%lf`, 0
    
    

section .text
global CMAIN
CMAIN:
    ;write your code here
    xor eax, eax
    ret