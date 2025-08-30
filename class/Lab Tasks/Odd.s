    .global _start
	.equ lb, 0xaaaaaaaa

_start:
    LDR R0, =array
    LDR R2, =lb
    LDR R1, [R0]
	ADD R3, R3, R1

loop:
	ldr R1,[R0,#8]!
    CMP R1, R2
    BGE end

    ADD R3, R3, R1
    B loop

end:
    .data
array:  .word 10, 3, 6, 13, 2, 5, 4