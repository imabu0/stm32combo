.equ sevenseg1, 0xff200020
.equ sevenseg2, 0xff200030

.global _start
_start:
    ldr r1, =sevenseg2
    ldr r2, =sevenseg1
    ldr r3, =#0b01100110000000000000000000000000
    ldr r4, =#0b0110011000000000
	mov r5, #0
	mov r6, #0
	
loop1:
	mov r6, #0
	str r4, [r1]
	ror r4, #8
	add r5, r5, #1
	cmp r5, #2
	bge skip
	b loop1
	
skip:
	mov r5, #-1
	str r4, [r1]
	ror r4, #8
	b loop2

loop2:
    str r3, [r2]
    ror r3, #8
	add r6, r6, #1
	cmp r6, #4
	bge loop1
    b loop2
