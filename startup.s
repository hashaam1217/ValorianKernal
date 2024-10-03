/* startup.s */

    .section .isr_vector,"a",%progbits
    .global _start

_start:
    LDR sp, =_stack_top    /* Initialize stack pointer */
    BL  main               /* Call main */
    B   .                  /* Infinite loop */

    .align 4
    .word _start           /* Reset Handler */
    .word 0                /* Undefined Instruction */
    .word 0                /* Software Interrupt */
    .word 0                /* Prefetch Abort */
    .word 0                /* Data Abort */
    .word 0                /* Unused */
    .word 0                /* IRQ */
    .word 0                /* FIQ */

