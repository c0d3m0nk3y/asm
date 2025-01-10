;  Build using these commands:
;    nasm -f elf64 -g -F stabs eatsyscall.asm
;    ld -o eatsyscall eatsyscall.o

SECTION .data
    EatMsg: db "Eat at Joe's!",10
    EatLen: equ $-EatMsg
SECTION .bss
SECTION .text
global main
main:
    mov rbp, rsp        ; for correct debugging
    mov rax, 1          ; sys_write for syscall
    mov rdi, 1          ; file descriptor for stdout
    mov rsi, EatMsg     ; Put message into rsi register
    mov rdx, EatLen     ; Length of message
    syscall
    mov rax, 60         ; sys_exit for syscall
    mov rdi, 0          ; Return value in rdi 0 = nothing to return
    syscall
