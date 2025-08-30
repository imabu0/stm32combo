    .section .data
solved: .word 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0
student: .word 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 1, 1
count:  .word 0

    .section .text
    .global _start

_start:
    ldr r0, =solved
    ldr r1, =student
    ldr r2, =count
    mov r3, #0 @ Student Score
    mov r4, #20 @ Total Questions
    mov r5, #0 @ Array index

compare:
    cmp r5, r4
    bge end @ Branch if r5>=r4

    ldr r6, [r0, r5, lsl #2]
    ldr r7, [r1, r5, lsl #2]
    cmp r6, r7 @ Compare solved with student
    beq matched @ If match found then go to matched

    b indexplusplus @ Else increase the index

matched:
    add r3, r3, #1 @ Add the score

indexplusplus:
    add r5, r5, #1 @ Set next index of the array
    b compare @ Go to compare

end:
    str r3, [r2] @ Store total score in the score
	swi 0