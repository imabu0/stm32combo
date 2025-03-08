.section .data
LIGHT_REG: .byte 0x00

.text
.global _start
.equ LED, 0xff200000

_start:

	LDR R0, =LIGHT_REG
	LDRB R1, [R0]
	LDR R2, =LED
	
	ORR R1, R1, #0b00000101
	STR R1, [R2]
	
	BIC R1, R1, #0b00001000
	STR R1, [R2]
	
	EOR R1, R1, #0b01000000
	STR R1, [R2]
	
	TST R1, #0b00100000
	BIC R1, R1, #0b00100000
	STR R1, [R2]
	
	STRB R1, [R0]
	
	SWI 0