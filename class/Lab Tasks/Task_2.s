.data
array: .word 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
sum: .word 0
.text
.global _start
_start:
	ldr r0, =array
	ldr r1, =sum
	mov r9, #0
	mov r3, #1
	
loop:
	cmp r3, #20
	bge end
	
	lsl r4, r3, #2
	ldr r5, [r0,r4]
	add r9, r9, r5
	
	add r3, r3, #2
	b loop
	
end:
	str r9, [r1]
    swi 0