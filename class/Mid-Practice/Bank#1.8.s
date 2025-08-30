.global _start
_start:
	
	mov r0, #100
	mov r1, #50
	mov r2, #30
	
	cmp r0, r1
	beq check_equal
	bgt comp_a_c
	
comp_a_c:
	cmp r0, r2
	bgt a_wins
	
comp_b_c:
	cmp r1, r2
	bgt b_wins
	b c_wins
	
check_equal:
	cmp r0, r2
	beq tie

a_wins:
	mov r3, #1
	b end
	
b_wins:
	mov r3, #2
	b end

c_wins:
	mov r3, #3
	b end
	
tie:
	mov r3, #0
	b end
	
end:
	swi 0