.syntax unified          @ Use unified ARM/Thumb assembly syntax
.cpu cortex-m3           @ Target Cortex-M3 CPU (STM32F103)
.fpu softvfp             @ Software floating-point support
.thumb                   @ Use Thumb instruction set

.equ RCC_BASE,    0x40021000      @ RCC base address
.equ RCC_APB2ENR, RCC_BASE + 0x18 @ APB2 peripheral clock enable register
.equ GPIOC_BASE,  0x40011000      @ GPIOC base address
.equ GPIOC_CRH,   GPIOC_BASE + 0x04 @ Port configuration register high (for pins 8-15)
.equ GPIOC_ODR,   GPIOC_BASE + 0x0C @ Port output data register
.equ LED_PIN,     13              @ Onboard LED is connected to PC13
.equ IOPCEN_BIT,  4               @ Bit position for GPIOC clock enable
.equ DELAY_COUNT, 1800000         @ Empirical value for ~1 second delay

.section .text
.global main

main:
    ldr r0, =RCC_APB2ENR         @ Load register address
    ldr r1, [r0]                 @ Read current value
    orr r1, r1, #(1 << IOPCEN_BIT) @ Set bit 4 (IOPCEN)
    str r1, [r0]                 @ Write back to enable clock

    ldr r0, =GPIOC_CRH            @ Load configuration register address
    ldr r1, [r0]                 @ Read current value
    bic r1, r1, #(0b1111 << 20)  @ Clear bits 20-23 for PC13
    orr r1, r1, #(0b0001 << 20)  @ Set to output push-pull, 10MHz
    str r1, [r0]                 @ Write back to register

loop:
    @ Turn LED OFF (set PC13 high - active low LED)
    ldr r0, =GPIOC_ODR            @ Load output data register address
    ldr r1, [r0]                 @ Read current value
    orr r1, r1, #(1 << LED_PIN)  @ Set PC13 bit (LED off)
    str r1, [r0]                 @ Write back to register

    @ Delay for approximately 1 second
    ldr r2, =DELAY_COUNT         @ Load delay counter value
delay_off:
    subs r2, r2, #1              @ Decrement counter
    bne delay_off                @ Continue until counter reaches zero

    @ Turn LED ON (clear PC13 - active low LED)
    ldr r0, =GPIOC_ODR            @ Load output data register address
    ldr r1, [r0]                 @ Read current value
    bic r1, r1, #(1 << LED_PIN)  @ Clear PC13 bit (LED on)
    str r1, [r0]                 @ Write back to register

    @ Delay for approximately 1 second
    ldr r2, =DELAY_COUNT         @ Load delay counter value
delay_on:
    subs r2, r2, #1              @ Decrement counter
    bne delay_on                 @ Continue until counter reaches zero

    @ Repeat the loop indefinitely
    b loop
