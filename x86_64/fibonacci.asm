; Does not write out.  Debug in SASM.

SECTION .data
SECTION .text
global main
main:
    mov rbp, rsp        ; for correct debugging
    nop
    mov ecx, 12         ; counter, how many terms of fib
    mov ebx, 1          ; 2nd fib term
    mov eax, 0          ; 1st fib term
do: mov edx, eax        ; temporarily store the highest term before we overwrite it for the next term
    add eax, ebx        ; calculate the next term
    mov ebx, edx        ; move the temp store in n-1 term
    dec ecx             ; decerease the counter
    jnz do
    nop
    mov rax, 60         ; sys_exit for syscall
    mov rdi, 0          ; Return value in rdi 0 = nothing to return
    syscall

SECTION .bss