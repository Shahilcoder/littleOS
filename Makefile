AS = nasm

all: boot.img

boot.img: boot.bin loader.bin
	dd if=boot.bin of=boot.img bs=512 count=1 conv=notrunc
	dd if=loader.bin of=boot.img bs=512 count=5 seek=1 conv=notrunc

%.bin: %.asm
	$(AS) -f bin -o $@ $<

run:
	bochs -f bochsrc.txt

clean:
	rm *.bin