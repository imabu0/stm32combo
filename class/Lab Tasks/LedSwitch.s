.global _start
.equ led, 0xff200000
.equ switch, 0xff200040

_start:
    ldr r0, =led
	ldr r1, =switch
	ldr r2,[r1]
	str r2,[r0]