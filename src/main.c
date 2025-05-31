int main(void)
{
    *(volatile unsigned long *)(0x40023800 + 0x30) |= (1 << 2);
    *(volatile unsigned long *)(0x40020000 + 0x400 * 2 + 0x00) &= ~(3UL << 26);
    *(volatile unsigned long *)(0x40020000 + 0x400 * 2 + 0x14) &= ~(1UL << 13);

    while (1)
    {
        *(volatile unsigned long *)(0x40020000 + 0x400 * 2 + 0x00) ^= (1UL << 26);
        for (unsigned long i = 0; i < 1000000; ++i);
    }
}

