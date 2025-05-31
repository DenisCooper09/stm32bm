CC       = arm-none-eabi-gcc
OBJC     = arm-none-eabi-objcopy
FLASH    = st-flash

MCPU     = cortex-m4
CFLAGS   = -mcpu=$(MCPU) -c
LFLAGS   = -T linker/link.ld -nostdlib

FIRMWARE = firmware
BUILDDIR = build
SRCDIR   = src

SOURCES  = bootloader.c main.c
OBJECTS  = $(patsubst %.c, $(BUILDDIR)/%.o, $(SOURCES))

ELF      = $(BUILDDIR)/$(FIRMWARE).elf
BIN      = $(BUILDDIR)/$(FIRMWARE).bin

all: $(BIN)

$(BUILDDIR):
	mkdir -p $(BUILDDIR)

$(BUILDDIR)/%.o: $(SRCDIR)/%.c | $(BUILDDIR)
	$(CC) $(CFLAGS) $< -o $@

$(ELF): $(OBJECTS)
	$(CC) $(LFLAGS) $^ -o $@

$(BIN): $(ELF)
	$(OBJC) -O binary $< $@

flash: $(BIN)
	$(FLASH) --reset write $(BIN) 0x8000000

clean:
	rm -rf $(BUILDDIR)

.PHONY: all clean flash

