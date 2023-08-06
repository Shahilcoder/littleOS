global loader                         ; the entry symbol for ELF

KERNEL_STACK_SIZE equ 4096            ; size of stack in bytes
MAGIC_NUMBER equ 0x1BADB002           ; define the magic number constant
FLAGS        equ 0x0                  ; multiboot flags
CHECKSUM     equ -MAGIC_NUMBER        ; calculate the checksum
                                      ; (magic number + checksum + flags = 0)

section .bss
align 4                               ; the code must be 4 byte aligned
kernel_stack:
    resb KERNEL_STACK_SIZE

section .text:                        ; start of the text (code) section
align 4                               ; the code must be 4 byte aligned
    dd MAGIC_NUMBER                   ; write the magic number to the machine code,
    dd FLAGS                          ; the flags
    dd CHECKSUM                       ; and the checksum

loader:                               ; the loader label (defined as entry point in linker script)
    extern fb_write_cell
    mov esp, kernel_stack + KERNEL_STACK_SIZE
    mov eax, 0xCAFEBABE

    ; write SHAHIL with help of C function
    push byte 0x00
    push byte 0x04
    push byte 0x53
    push dword 0x00000050

    call fb_write_cell

    push byte 0x00
    push byte 0x04
    push 0x48
    push dword 0x00000051

    call fb_write_cell

    push byte 0x00
    push byte 0x04
    push 0x41
    push dword 0x00000052

    call fb_write_cell

    push byte 0x00
    push byte 0x04
    push 0x48
    push dword 0x00000053

    call fb_write_cell

    push byte 0x00
    push byte 0x04
    push 0x49
    push dword 0x00000054

    call fb_write_cell

    push byte 0x00
    push byte 0x04
    push 0x4C
    push dword 0x00000055

    call fb_write_cell

    ; Write HUSSAIN on the frame buffer via Assembly
    mov [0x000B80AE], word 0x0448         ; access the framebuffer via Memory mapped io, and write 'H' with green color and dark grey background
    mov [0x000B80B0], word 0x0455         ; write second cell (after 4 bits) [:( I dunno how it works] U
    mov [0x000B80B2], word 0x0453         ; write S
    mov [0x000B80B4], word 0x0453         ; write S
    mov [0x000B80B6], word 0x0441         ; write A
    mov [0x000B80B8], word 0x0449         ; write I
    mov [0x000B80BA], word 0x044E         ; write N

.loop:
    jmp .loop                         ; loop forever
