extern int   main   (void);
extern void _estack (void);

__attribute__((naked, noreturn)) void _reset(void)
{
    extern long _sbss, _ebss, _sdata, _edata, _sidata;

    for (long *dst = &_sbss                  ; dst < &_ebss ; dst++) *dst   = 0x00;
    for (long *dst = &_sdata, *src = &_sidata; dst < &_edata;      ) *dst++ = *src++;

    main();

    while (1) (void)0;
}

__attribute__((section(".vectors"))) void (*const vtab[16 + 85])(void) =
{
    _estack,
    _reset
};

