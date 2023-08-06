OBJECTS = loader.o kmain.o
CC = gcc
CFLAGS = -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -c
LDFLAGS = -T link.ld -melf_i386
AS = nasm
ASFLAGS = -f elf

all: os.iso

os.iso: kernel.elf
	cp kernel.elf iso/boot/kernel.elf
	genisoimage -R	\
		    -b boot/grub/stage2_eltorito	\
		    -no-emul-boot	\
		    -boot-load-size 4	\
		    -o os.iso	\
		    iso

kernel.elf: $(OBJECTS)
	ld $(LDFLAGS) $(OBJECTS) -o kernel.elf

%.o: %.c
	$(CC) $(CFLAGS) $<

run: os.iso
	bochs -f bochsrc.txt -q

clean:
	rm -rf *.o kernel.elf os.iso bochslog.txt
