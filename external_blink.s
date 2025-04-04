.syntax unified              @ Use unified ARM/Thumb assembly syntax
.cpu cortex-m3               @ Target Cortex-M3 CPU (STM32F103)
.fpu softvfp                 @ Software floating-point support
.thumb                       @ Use Thumb instruction set

.equ RCC_BASE,      0x40021000      @ RCC base address
.equ GPIOA_BASE,    0x40010800      @ GPIOA base address
.equ RCC_APB2ENR,   RCC_BASE + 0x18     @ APB2 peripheral clock enable register
.equ GPIOA_CRL,     GPIOA_BASE + 0x00   @ GPIOA config register low (PA0–PA7)
.equ GPIOA_ODR,     GPIOA_BASE + 0x0C   @ GPIOA output data register
.equ LED_PIN,       0              @ PA0
.equ IOPAEN_BIT,    2              @ Bit 2 enables GPIOA clock
.equ DELAY_COUNT,   1800000        @ Approximate value for 1-second delay @ 72 MHz

.section .text
.global main

main:
    ldr r0, =RCC_APB2ENR         @ Load APB2ENR register address
    ldr r1, [r0]                 @ Read current value
    orr r1, r1, #(1 << IOPAEN_BIT) @ Set bit 2 (IOPAEN)
    str r1, [r0]                 @ Enable GPIOA clock
    ldr r0, =GPIOA_CRL           @ Load GPIOA_CRL address (PA0 is pin 0–3 in CRL)
    ldr r1, [r0]                 @ Read current CRL value
    bic r1, r1, #(0b1111 << 0)   @ Clear CNF0[1:0] and MODE0[1:0] (bits 0–3)
    orr r1, r1, #(0b0001 << 0)   @ MODE0 = 01 (Output, 10 MHz), CNF0 = 00 (Push-pull)
    str r1, [r0]                 @ Write updated value back to CRL

loop:
    @ --- Turn LED ON (set PA0 HIGH) ---
    ldr r0, =GPIOA_ODR           @ Load output data register address
    ldr r1, [r0]                 @ Read current output state
    orr r1, r1, #(1 << LED_PIN)  @ Set PA0 high
    str r1, [r0]                 @ Write back to ODR

    @ --- Delay (~1 second) ---
    ldr r2, =DELAY_COUNT         @ Load delay counter value
delay_on:
    subs r2, r2, #1              @ Decrement counter
    bne delay_on                 @ Loop until zero

    @ --- Turn LED OFF (clear PA0) ---
    ldr r0, =GPIOA_ODR           @ Load output data register address
    ldr r1, [r0]                 @ Read current output state
    bic r1, r1, #(1 << LED_PIN)  @ Clear PA0 (set LOW)
    str r1, [r0]                 @ Write back to ODR

    @ --- Delay (~1 second) ---
    ldr r2, =DELAY_COUNT         @ Load delay counter value
delay_off:
    subs r2, r2, #1              @ Decrement counter
    bne delay_off                @ Loop until zero

    @ --- Repeat ---
    b loop
