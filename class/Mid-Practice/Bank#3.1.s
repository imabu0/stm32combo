.section .data
STATUS_REG: .byte 0x00

.section .text
.global _start
_start:
    LDR R0, =STATUS_REG

    LDRB R1, [R0]

    ORR R1, R1, #0x03

    BIC R1, R1, #0x04

    EOR R1, R1, #0x08

    TST R1, #0x10
    BICNE R1, R1, #0x10

    STRB R1, [R0]

    SWI 0