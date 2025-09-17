#include "stm32f10x.h"

void delay(int time) {
    for (int i = 0; i < time * 1000; i++);
}

int main(void) {
    // Enable GPIOC Clock
    RCC->APB2ENR |= (1 << 4);

    // Configure PC13 as output (Push-pull, Max speed 2MHz)
    GPIOC->CRH &= ~(0xF << 20);
    GPIOC->CRH |= (0x1 << 20);

    while (1) {
        GPIOC->ODR ^= (1 << 13); // Toggle PC13
        delay(500); // Delay for blinking effect
    }
}
