SECTION .data
        Snippet db "KANGAROO"

SECTION .text
        global main
main:
        mov rbp, rsp        ; for correct debugging
        nop
        mov rbx, Snippet
        mov rax, 8
DoMore: add byte [rbx], 32
        inc rbx
        dec rax
        jnz DoMore
        nop
        mov rax, 60         ; sys_exit for syscall
        mov rdi, 0          ; Return value in rdi 0 = nothing to return
        syscall

SECTION .bss