.syntax unified
.cpu cortex-m3
.fpu softvfp
.thumb

.global main

.equ RCC_APB2ENR,  0x40021018  // RCC APB2 Peripheral Clock Enable Register
.equ GPIOA_BASE,    0x40010800  // GPIOA Base Address
.equ GPIOA_CRL,     0x40010800  // GPIOA Configuration Register Low (CRL)
.equ GPIOA_BSRR,    0x40010810  // GPIOA Bit Set/Reset Register
.equ GPIOA_IDR,     0x40010808  // GPIOA Input Data Register

.section .data
REG: .word 0b0001001  // Initial LED states (PA7 to PA0)

.section .text
main:
    // Enable GPIOA Clock
    LDR R0, =RCC_APB2ENR
    LDR R1, [R0]
    ORR R1, R1, #(1 << 2)    // Enable GPIOA clock
    STR R1, [R0]

    // Configure PA6, PA5, PA3, PA2, and PA0 as Output
    LDR R0, =GPIOA_CRL
    LDR R1, [R0]

    BIC R1, R1, #(0b1111 << 24)  // Clear bits for PA6
    ORR R1, R1, #(0b0011 << 24)  // Set PA6 as Output (50MHz, Push-Pull)

    BIC R1, R1, #(0b1111 << 20)  // Clear bits for PA5
    ORR R1, R1, #(0b0011 << 20)  // Set PA5 as Output (50MHz, Push-Pull)

    BIC R1, R1, #(0b1111 << 12)  // Clear bits for PA3
    ORR R1, R1, #(0b0011 << 12)  // Set PA3 as Output (50MHz, Push-Pull)

    BIC R1, R1, #(0b1111 << 8)   // Clear bits for PA2
    ORR R1, R1, #(0b0011 << 8)   // Set PA2 as Output (50MHz, Push-Pull)

    BIC R1, R1, #(0b1111 << 0)   // Clear bits for PA0
    ORR R1, R1, #(0b0011 << 0)   // Set PA0 as Output (50MHz, Push-Pull)

    STR R1, [R0]

    // Load initial state from REG
    LDR R0, =REG
    LDR R1, [R0]

    // Turn ON PA0 and PA2 unconditionally
    LDR R0, =GPIOA_BSRR
    MOV R1, #(1 << 0) | (1 << 2) // Set PA0 and PA2
    STR R1, [R0]

    // Update REG to reflect PA0 and PA2 are ON
    LDR R0, =REG
    LDR R1, [R0]
    ORR R1, R1, #(1 << 0) | (1 << 2) // Set bits for PA0 and PA2
    STR R1, [R0]

    // Check if PA6 (bit 6) is ON or OFF
    LDR R0, =REG
    LDR R1, [R0]
    TST R1, #(1 << 6)  // Test bit 6 (PA6)
    BEQ turn_on        // If bit 6 is 0 (OFF), turn on LED

turn_off:
    // Turn off LED at PA6
    LDR R0, =GPIOA_BSRR
    MOV R1, #(1 << (6 + 16))  // Reset PA6 (Bit 22 in BSRR)
    STR R1, [R0]

    // Update REG: Clear PA6 bit
    LDR R0, =REG
    LDR R1, [R0]
    BIC R1, R1, #(1 << 6) // Clear bit 6
    STR R1, [R0]

    B check_pa5  // Jump to PA5 check

turn_on:
    // Turn on LED at PA6
    LDR R0, =GPIOA_BSRR
    MOV R1, #(1 << 6)  // Set PA6
    STR R1, [R0]

    // Update REG: Set PA6 bit
    LDR R0, =REG
    LDR R1, [R0]
    ORR R1, R1, #(1 << 6) // Set bit 6
    STR R1, [R0]

check_pa5:
    // Check if PA5 (bit 5) is ON
    LDR R0, =REG
    LDR R1, [R0]
    TST R1, #(1 << 5)  // Test bit 5 (PA5)
    BEQ turn_off_pa3   // If PA5 is OFF, do nothing

    // Turn off PA5 if it was ON
    LDR R0, =GPIOA_BSRR
    MOV R1, #(1 << (5 + 16))  // Reset PA5 (Bit 21 in BSRR)
    STR R1, [R0]

    // Update REG: Clear PA5 bit
    LDR R0, =REG
    LDR R1, [R0]
    BIC R1, R1, #(1 << 5) // Clear bit 5
    STR R1, [R0]

turn_off_pa3:
    // Turn off LED at PA3
    LDR R0, =GPIOA_BSRR
    MOV R1, #(1 << (3 + 16))  // Reset PA3 (Bit 19 in BSRR)
    STR R1, [R0]

    // Update REG: Clear PA3 bit
    LDR R0, =REG
    LDR R1, [R0]
    BIC R1, R1, #(1 << 3) // Clear bit 3
    STR R1, [R0]

infinite_loop:
    B infinite_loop  // Stay here

.end
