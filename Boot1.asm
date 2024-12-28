org 0x7C00

bits 16

Start:
  cli
  hlt

; $ current line - $$ start of program = size of the program
times 510 - ($-$$) db 0

; here's the remaining two bytes
; byte 511 = 0xAA, byte 512 = 0x55.
; BIOS INT 0x19 searches for this boot signature.
dw 0xAA55

