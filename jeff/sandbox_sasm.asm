SECTION .bss

SECTION .data

SECTION .text
global main
main:
    mov rbp, rsp                ; for correct debugging
    nop
    
    xor rcx, rcx
    mov cl, 10000b
    rol cl, 1
    rol cl, 1
    rol cl, 1
    rol cl, 1
    rol cl, 1

    nop
    mov rax, 60                 ; sys_exit for syscall
    mov rdi, 0                  ; Return value in rdi 0 = nothing to return
    syscall
