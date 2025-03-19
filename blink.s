    AREA RESET, CODE, READONLY
    THUMB

    EXPORT __main
__main  
    LDR R0, =0x40021018   ; RCC_APB2ENR address (Enable GPIOC Clock)
    LDR R1, [R0]          
    ORR R1, R1, #0x10     ; Set bit 4 (IOPCEN)
    STR R1, [R0]

    LDR R0, =0x40011004   ; GPIOC_CRH address (Configure PC13 as output)
    LDR R1, [R0]
    BIC R1, R1, #(0xF << 20) ; Clear CNF & MODE for PC13
    ORR R1, R1, #(0x1 << 20) ; MODE = 01 (Output, 10MHz)
    STR R1, [R0]

blink_loop
    LDR R0, =0x4001100C   ; GPIOC_ODR address
    LDR R1, [R0]
    EOR R1, R1, #(1 << 13) ; Toggle PC13
    STR R1, [R0]

    BL delay               ; Call delay function
    B blink_loop           ; Repeat forever

delay
    LDR R2, =10000000         ; Adjust this for blinking speed
delay_loop
    SUBS R2, R2, #1
    BNE delay_loop
    BX LR                   ; Return from delay

    END