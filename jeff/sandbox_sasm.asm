SECTION .bss

SECTION .data

SECTION .text
global main
main:
    mov rbp, rsp        ; for correct debugging
    nop
    
    xor rcx,rcx
    mov cl,1 
    shl cl,cl
    shl cl,cl

    nop
    mov rax, 60         ; sys_exit for syscall
    mov rdi, 0          ; Return value in rdi 0 = nothing to return
    syscall
