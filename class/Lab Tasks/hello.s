.equ sevenseg1, 0xff200020
.equ sevenseg2, 0xff200030
.equ switch, 0xff200040

.global _start
_start:
    ldr r1, =sevenseg1
	ldr r2, =sevenseg2
	ldr r3, =#0b01111001001110000011100000111111
	str r3,[r1]
	ldr r4, =#0b01110110
	str r4,[r2]
	swi 0