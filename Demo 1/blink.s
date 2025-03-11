.global main
.equ RCC_APB2ENR, 0x40021018
.equ GPIOC_BASE, 0x40011000
.equ GPIOC_CRH, GPIOC_BASE + 0x04
.equ GPIOC_ODR, GPIOC_BASE + 0x0C
.equ LED_PIN, (1 << 13)

main:
    LDR R0, =RCC_APB2ENR
    LDR R1, [R0]
    ORR R1, R1, #(1 << 4)   @ Enable GPIOC clock
    STR R1, [R0]

    LDR R0, =GPIOC_CRH
    LDR R1, [R0]
    BIC R1, R1, #(0xF << 20) @ Clear CNF & MODE for PC13
    ORR R1, R1, #(0x1 << 20) @ Set PC13 as output (Max speed 10MHz)
    STR R1, [R0]

blink:
    LDR R0, =GPIOC_ODR
    LDR R1, [R0]
    EOR R1, R1, #LED_PIN     @ Toggle PC13
    STR R1, [R0]

    MOV R2, #500000
delay:
    SUBS R2, R2, #1
    BNE delay

    B blink
