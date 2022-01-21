%include "/home/boris/prak/asm_1_1/io.inc"

section .bss
	a resd 1
	b resd 1
	c resd 1
	v resd 1

section .text
global CMAIN
CMAIN:
	GET_DEC 4, [a]
	GET_DEC 4, [b]
	GET_DEC 4, [c]
	GET_DEC 4, [v]
	mov eax , dword[a]
	imul eax, dword[b]
	imul eax, dword[c]
	cdq
	idiv dword[v]
	PRINT_DEC 4, eax
	xor eax, eax
	ret
