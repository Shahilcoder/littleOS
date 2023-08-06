typedef unsigned char byte;

typedef struct fb {
    byte ch;
    byte bgfg;
} __attribute__((packed)) fb;

fb *fbp = (fb*)0x000B8000;

/** fb_write_cell:
* Writes a character with the given foreground and background to position i
* in the framebuffer.
*
* @param i The location in the framebuffer
* @param c The character
* @param fg The foreground color
* @param bg The background color
*/

void fb_write_cell(unsigned int i, char c, unsigned char fg, unsigned char bg) {
    fbp[i].bgfg = ((bg & 0x0F) << 4) | (fg & 0x0F);
    fbp[i].ch = c;
}