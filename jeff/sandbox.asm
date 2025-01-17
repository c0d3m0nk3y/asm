;  Build using these commands:
;    nasm -f elf64 -g -F dwarf sandbox.asm
;    ld -o sandbox.bin sandbox.o

SECTION .data
SECTION .text
global main
main:
    mov rbp, rsp        ; for correct debugging
    nop
    xor rax, rax
    xor rbx, rbx
    mov ax, 77
    push ax
    pop bx
    nop
    mov rax, 60         ; sys_exit for syscall
    mov rdi, 0          ; Return value in rdi 0 = nothing to return
    syscall

SECTION .bss