SECTION .data

SECTION .bss

SECTION .text
global main
main:
    mov rbp, rsp        ; for correct debugging
    nop
    
    xor rax, rax
    xor rbx, rbx
    mov rax, 0fh
    push rax
    pop rbx
    
    pop rcx             ; base pointer above stack pointer, instead of wrap around?
    mov rbp, 0          ; now we are at risk of overwriting our code

    nop
    mov rax, 60         ; sys_exit for syscall
    mov rdi, 0          ; Return value in rdi 0 = nothing to return
    syscall
