SECTION .data
SECTION .text
global main
main:
    mov rbp, rsp        ; for correct debugging
    nop
    mov eax, 0ffffffffh
    mov ebx, 033h
    mul ebx
    nop
    mov rax, 60         ; sys_exit for syscall
    mov rdi, 0          ; Return value in rdi 0 = nothing to return
    syscall

SECTION .bss