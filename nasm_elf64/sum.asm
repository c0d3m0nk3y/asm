SYS_EXIT equ 1
SYS_READ equ 3
SYS_WRITE equ 4
STDIN equ 0
STDOUT equ 1

segment .bss
  sum resb 1
segment .text
  global main
.main:
  mov eax, '3'
  sub eax, '0'
  mov ebx, '4'
  sub ebx, '0'
  add eax, ebx
  add eax, '0'
  move [sum], eax
  mov ecx, msg
  mov edx, len
  mov ebx, STDOUT
  mov eax, SYS_WRITE
  int 0x80
  nwln
  mov ecx, sum
  mov edx, 1
  mov ebx, STDOUT
  mov eax, SYS_WRITE
  int 0x80
  mov eax, SYS_EXIT
  int 0x80

section .data
  msg db "Sum ", 0XA, 0XD
  len equ $ - msg
  segment .bss
  sum resb 1
