ENTRY(_reset)

MEMORY
{
    flash(rx)  : ORIGIN = 0x08000000, LENGTH = 512k
    sram1(rwx) : ORIGIN = 0x20000000, LENGTH = 128k
}

SECTIONS
{
    _estack = ORIGIN(sram1) + LENGTH(sram1);

    .vectors : { KEEP(*(.vectors)) } > flash
    .text    : { *(.text*) }         > flash
    .rodata  : { *(.rodata*) }       > flash

    .data : {
        _sdata = .;
        *(.first_data)
        *(.data SORT(.data.*))
        _edata = .;
    } > sram1 AT > flash

    _sidata = LOADADDR(.data);

    .bss : {
        _sbss = .;
        *(.bss SORT(.bss.*) COMMON)
        _ebss = .;
    } > sram1
}

