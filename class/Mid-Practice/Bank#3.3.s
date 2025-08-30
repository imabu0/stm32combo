.section .data
LIGHT_REG: .byte 0x00

.text
.global _start
_start:

	LDR R0, =LIGHT_REG
	LDRB R1, [R0]
	
	ORR R1, R1, #0b00000001
	
	BIC R1, R1, #0b00011000
	
	EOR R1, R1, #0b00100000
	
	STRB R1, [R0]
	
	SWI 0