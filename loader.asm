[BITS 16]
[ORG 0x7e00]

start:
    ; print message for now
    mov ah, 0x13
    mov al, 1
    mov bx, 0xa
    xor dx, dx
    mov bp, Message
    mov cx, MessageLen
    int 0x10

End:
    hlt
    jmp End

Message:
    db "Loader starts"
MessageLen equ $-Message