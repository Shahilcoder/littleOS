AS = nasm

all: boot.img

boot.img: boot.bin
	dd if=boot.bin of=boot.img bs=512 count=1 conv=notrunc

boot.bin: boot.asm
	$(AS) -f bin -o boot.bin boot.asm

run:
	bochs -f bochsrc.txt

clean:
	rm boot.bin