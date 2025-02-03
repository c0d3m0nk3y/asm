SECTION .bss

SECTION .data

SECTION .text
global main
main:
    mov rbp, rsp                ; for correct debugging
    nop
    
    xor rbx, rbx                ; zero out rbx
    
    mov rbx, 01010110B
    not rbx                     ; invert bits
    add rbx, 1                  ; add one

    nop
    mov rax, 60                 ; sys_exit for syscall
    mov rdi, 0                  ; Return value in rdi 0 = nothing to return
    syscall
