.section .data
LIGHT_REG: .byte 0x00

.text
.global main
.equ GPIOA, 0x40010800
.equ RCC_APB2ENR, 0x40021018

main:
    LDR R0, =LIGHT_REG
    LDRB R1, [R0]
    LDR R2, =GPIOA

    LDR R3, =0x00000003
    STR R3, [R2]        

    LDR R3, =0x00000004
    LDR R4, =RCC_APB2ENR
    STR R3, [R4]

    ORR R1, R1, #0b00000011
    STR R1, [R2, #0x0C]

    BIC R1, R1, #0b00001000
    STR R1, [R2, #0x0C]

    EOR R1, R1, #0b01000000
    STR R1, [R2, #0x0C]

    TST R1, #0b00100000
    BIC R1, R1, #0b00100000
    STR R1, [R2, #0x0C]

    STRB R1, [R0]

    B .