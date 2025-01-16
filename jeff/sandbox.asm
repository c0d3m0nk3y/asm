;  Build using these commands:
;    nasm -f elf64 -g -F dwarf sandbox.asm
;    ld -o sandbox.bin sandbox.o

SECTION .data
SECTION .text
global main
main:
    mov rbp, rsp        ; for correct debugging
    nop
    nop
    mov rax, 60         ; sys_exit for syscall
    mov rdi, 0          ; Return value in rdi 0 = nothing to return
    syscall

SECTION .bss