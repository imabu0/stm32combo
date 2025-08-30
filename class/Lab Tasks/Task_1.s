.global _start
_start:
	MOV R1, #15
	MOV R2, #14
	MOV R3, #13
	MOV R4, #12
	
	ADD R10, R1, R2
	MOV R11, #4
	MUL R12, R10, R11
	SUB R0, R12, R4
	
	CMP R0, #104
	BEQ L1
	BLT L2
	BGT L3
	
L1:
	SUB R5, R1, R3
	ADD R6, R1, R2
	ORR R7, R5, R6
	MOV R8, #3
	MUL R9, R7, R8
	SWI 0
L2:
	SUB R5, R1, R2
	ADD R6, R5, R3
	EOR R9, R6, #11
	SWI 0
L3:
	MOV R9, #7
	SWI 0