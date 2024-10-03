/* linker.ld */
MEMORY
{
    DDR = ORIGIN = 0x00000000, LENGTH = 0x40000000 /* 1GB */
}

SECTIONS
{
    .text :
    {
        *(.text*)
    } > DDR

    .data :
    {
        *(.data*)
    } > DDR

    .bss :
    {
        *(.bss*)
    } > DDR
}

