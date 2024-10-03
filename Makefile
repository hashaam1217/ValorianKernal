# Makefile

CC = arm-none-eabi-gcc
CFLAGS = -mcpu=arm926ej-s -g -O2 -Wall -Wextra -ffreestanding
LDFLAGS = -T link.ld -nostdlib
ASFLAGS = -mcpu=arm926ej-s -g

all: hello_world.elf

hello_world.elf: startup.o main.o
	$(CC) $(LDFLAGS) -o $@ $^

startup.o: startup.s
	$(CC) $(ASFLAGS) -c $< -o $@

main.o: main.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f *.o *.elf

