;  Build using these commands:
;    nasm -f elf64 -g -F dwarf sandbox.asm
;    ld -o sandbox.bin sandbox.o

SECTION .bss

SECTION .data
    Message: db "Hello, World!", 10
    Length: equ $-Message

SECTION .text
global _start
_start:
    push rbp
    mov rbp, rsp                ; for correct debugging
    
    mov rax, 1
    mov rdi, 1
    mov rsi, Message
    mov rdx, Length
    syscall
    
    mov rax, 60                 ; sys_exit for syscall
    mov rdi, 0                  ; Return value in rdi 0 = nothing to return
    syscall
