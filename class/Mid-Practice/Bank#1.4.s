.global _start
_start:
	
	mov r0, #10
	mov r1, #10
	mov r2, #10
	
	cmp r0, r1
	beq check_equal_r2
	bgt check_r2
	mov r0, r1

check_r2:
	cmp r0, r2
	bgt end
	mov r0, r2
	b end

check_equal_r2:
	cmp r0, r2
	beq all_equal
	b check_r2

all_equal:
	mov r0, #0

end:
	mov r3, r0
	SWI 0