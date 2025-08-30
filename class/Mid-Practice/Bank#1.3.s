.global _start
_start:
	
	mov r0, #15
	mov r1, #27
	mov r2, #9
	
	cmp r0, r1
    bgt check_r2
	mov r0, r1

check_r2:
	cmp r0, r2
    bgt end
	mov r0, r2

end:
	mov r3, r0
	SWI 0