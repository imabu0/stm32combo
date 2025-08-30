.global _start
_start:
	
	mov r0, #10
	mov r1, #20
	mov r2, #30
	
	cmp r0, #50
	bgt transfer
	ble penalty
	
transfer:
	sub r1, r1, #30
	add r2, r2, #30
	b bonus
	
penalty:
	sub r2, r2, #10
	add r1, r1, #10
	
bonus:
	cmp r2, #100
	blt end
	add r0, r0, #20
	add r1, r1, #20
	
end:
	mov r7, #1
	swi 0