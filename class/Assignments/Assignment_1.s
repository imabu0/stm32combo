.global _start
_start:
	mov r1, #0x00 @ Initialize r1 to 0b00000000
    
	@ Task 1 : Turn on living room lights and heating system
	orr r2, r1, #0b00000101 @ r1 = r1 OR 0b00000101
	
	@ Task 2 : Turn off air conditioner system
	bic r3, r1, #0b00001000 @ r1 = r1 AND NOT 0b00001000
	
	@ Task 3 : Toggle security alarm
	eor r4, r1, #0b01000000 @ r1 = r1 XOR 0b01000000
	
	@ Task 4 : Check if garage door is open, and if it is, close it
	tst r5, #0b00100000 @ Test if bit 5 is 1
    beq exit @ If bit 5 is 0, branch to 'end'
	@ If bit 5 was set, clear it
    bic r1, r1, #0b00100000 @ r1 = r1 AND NOT 0b00100000
exit:
    b exit