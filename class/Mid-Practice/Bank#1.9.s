.global _start
_start:
	
	mov r0, #28
	mov r1, #27
	mov r2, #29
	
	cmp r0, r1
	bge check_r0_r2
	cmp r1, r2
	bge store_2
	b store_3

check_r0_r2:
	cmp r0, r2
	bge store_1
	b store_3

store_1:
	mov r3, #1
	b end

store_2:
	mov r3, #2
	b end

store_3:
	mov r3, #3

end:
	SWI 0
