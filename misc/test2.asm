%include "io64.inc"

section .data
    a db 0x40
      dw 0x81
      db 0xfe
    b dd 0

section .text
global CMAIN
CMAIN:
    xor eax, eax
    movsx ax, byte [a + 1]
    mov dword [b], eax
    PRINT_HEX 4, [b]
    xor rax, rax
    ret