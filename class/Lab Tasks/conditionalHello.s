.equ sevenseg1, 0xff200020
.equ sevenseg2, 0xff200030
.equ switch, 0xff200040

.global _start
_start:
    ldr r1, =sevenseg1
    ldr r2, =sevenseg2
    ldr r3, =switch
    ldr r4, [r3]
    mov r5, #0x0C
    and r6, r4, r5
    cmp r6, #0x04
    beq zerofive
    cmp r6, #0x08
    beq zerofive
    b hello

zerofive:
    ldr r7, =0b0011111101101101
    str r7, [r1]
	ldr r8, =0
    str r8, [r2]
    swi 0

hello:
    ldr r7, =0b01111001001110000011100000111111
    str r7, [r1]
    ldr r8, =0b01110110
    str r8, [r2]
    swi 0