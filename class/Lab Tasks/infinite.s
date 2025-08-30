.global _start
.equ led, 0xff200000

_start:
    ldr r0, =led
    mov r1, #0x1
    mov r2, #0x2

loop:
    str r1, [r0]
    bl delay
    lsl r1, r1, r2
    cmp r1, #0x400
    moveq r1, #0x1
    b loop

delay:
    mov r3, #0x100000
delay_loop:
    subs r3, r3, #1
    bne delay_loop
    bx lr