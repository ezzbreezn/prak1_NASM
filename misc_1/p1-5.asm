%include "io.inc"


section .text
global CMAIN
CMAIN:
    GET_UDEC 4, edi ;n
    GET_UDEC 4, ecx ;m
    ror edi, cl
    PRINT_UDEC 4, edi
    xor eax, eax
    ret