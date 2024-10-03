/* link.ld */
ENTRY(_start)

MEMORY
{
    RAM (rxw) : ORIGIN = 0x00000000, LENGTH = 128M
}

SECTIONS
{
    . = ORIGIN(RAM);

    .text : {
        KEEP(*(.isr_vector))
        *(.text*)
        *(.rodata*)
    } > RAM

    .data : {
        _data = .;
        *(.data*)
        *(.data*)
        _edata = .;
    } > RAM AT > RAM

    .bss : {
        _bss_start = .;
        *(.bss*)
        *(COMMON)
        _bss_end = .;
    } > RAM

    . = ALIGN(8);
    _end = .;
    PROVIDE(_stack_top = ORIGIN(RAM) + LENGTH(RAM));
}

