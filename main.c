/* main.c */
#include <stdint.h>

// Define UART0 base address (for ARM926EJ-S on VersatilePB)
#define UART0_BASE 0x101f1000

// UART Register Offsets
#define UART_DR      (*(volatile uint32_t *)(UART0_BASE + 0x00))
#define UART_FR      (*(volatile uint32_t *)(UART0_BASE + 0x18))
#define UART_IBRD    (*(volatile uint32_t *)(UART0_BASE + 0x24))
#define UART_FBRD    (*(volatile uint32_t *)(UART0_BASE + 0x28))
#define UART_LCRH    (*(volatile uint32_t *)(UART0_BASE + 0x2C))
#define UART_CR      (*(volatile uint32_t *)(UART0_BASE + 0x30))

// UART Flags
#define UART_FR_TXFF (1 << 5)

// Function to initialize UART0
void uart_init(void) {
    // Disable UART0
    UART_CR = 0x0;

    // Set baud rate to 115200
    // UART clock is 24 MHz on VersatilePB
    UART_IBRD = 13;  // Integer part of baud rate divisor
    UART_FBRD = 1;   // Fractional part of baud rate divisor

    // Line control: 8 bits, no parity, 1 stop bit, FIFO enabled
    UART_LCRH = (3 << 5) | (1 << 4) | (1 << 6);

    // Enable UART0, TX, and RX
    UART_CR = (1 << 0) | (1 << 8) | (1 << 9);
}

// Function to send a character
void uart_send(char c) {
    // Wait until TX FIFO is not full
    while (UART_FR & UART_FR_TXFF);
    UART_DR = c;
}

// Function to send a string
void uart_send_string(const char *str) {
    while (*str) {
        uart_send(*str++);
    }
}

// Entry point
int main(void) {
    uart_init();
    uart_send_string("Hello World\n");

    // Infinite loop to prevent the program from exiting
    while (1);

    return 0;
}

