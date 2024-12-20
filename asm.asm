.global _start
.intel_syntax noprefix

_start:
  mov rax, 1 # syscall sys_write
  mov rdi, 1 # file descriptor std_out
  lea rsi, [hello_world]
  mov rdx, 14 # buffer length
  syscall 

  # sys_exit
  mov rax, 60
  mov rdi, 69
  syscall

hello_world:
  .asciz "Hello, world!\n"
