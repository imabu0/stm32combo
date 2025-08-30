.section .data
DOOR_REG: .hword 0x0000

.text
.global _start
_start:
    LDR R0, =DOOR_REG

    LDRH R1, [R0]

    ORR R1, R1, #0x000F

    TST R1, #0x00F0
    ORRNE R1, R1, #0x00F0

    EOR R1, R1, #0x0F00

    STRH R1, [R0]

    SWI 0