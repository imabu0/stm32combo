.equ sevenseg1, 0xff200020
.equ sevenseg2, 0xff200030
.equ push, 0xff200050

.global _start
_start:
    ldr r0, =sevenseg2
    ldr r1, =sevenseg1
	ldr r7, =push
	ldr r8, [r7]
    mov r4, #16
    mov r2, #2
    mov r6, #5
    mov r5, #4
    sdiv r4, r4, r5
    add r3, r4, r2
    mul r3, r3, r6
	cmp r3, #0
	bne loop1
    
	mov r9, #0x04
	and r7, r9, r7
	
	cmp r7, #0x04
	beq loop1
	
loop1:
	mov r6, #0
	str r4, [r1]
	ror r4, #8
	add r5, r5, #1
	cmp r5, #2
	bge skip
	b loop1
	
skip:
	str r4, [r1]
	ror r4, #8
	b loop2

loop2:
	mov r5, #0
    str r3, [r2]
    ror r3, #8
	add r6, r6, #1
	cmp r6, #4
	bge loop1
    b loop2