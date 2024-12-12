SYS_EXIT    equ 1
SYS_WRITE   equ 4
STD_IN      equ 0
STD_OUT     equ 1

section .text
  global main
main:
  mov eax, SYS_WRITE
  mov ebx, STD_OUT
  mov ecx, msg1
  mov edx, len1
  int 0x80

  mov eax, SYS_WRITE
  mov ebx, STD_OUT
  mov ecx, msg2
  mov edx, len2
  int 0x80

  mov eax, SYS_EXIT
  int 0x80

section .data
  msg1 db 'This is message one.', 0xA, 0xD
  len1 equ $ - msg1
  msg2 db 'What is 0xA and 0xD???', 0xA, 0xD
  len2 equ $ - msg2

