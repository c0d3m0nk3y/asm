; Converts all lowercase to uppercase
; ./uppercaser > output < input

section .bss
    Buff resb 1

section .data
    ErrBuff: db "Read buffer error",10
    ErrBuffLen: equ $-ErrBuff

section .text
global main
main:
    mov rbp, rsp

Read:
    mov rax, 0              ; sys_read
    mov rdi, 0              ; std_in
    mov rsi, Buff           ; addreas of buffer to write to
    mov rdx, 1              ; number of characters to read
    syscall
    
    cmp rax, -1             ; check sys_read return value
    je BuffReadErr          ; -1 means ERROR
    
    cmp rax, 0              ; check sys_read return value
    je Exit                 ; 0 means EOF (zero bytes read)
    
    cmp byte [Buff], 61h    ; compare buffer to 'a'
    jb Write                ; jump to Write if lower
    cmp byte [Buff], 7Ah    ; compare buffer to 'z'
    ja Write                ; jump to Write if higher
    
    sub byte [Buff], 20h    ; subtract 0x20, converts lowercase ASCII to upper
    
Write:
    mov rax, 1              ; sys_write
    mov rdi, 1              ; std_out
    mov rsi, Buff           ; address of character to write
    mov rdx, 1              ; number of characters to write
    syscall
    jmp Read                ; get the next character

BuffReadErr:
    mov rax, 1              ; sys_write
    mov rdi, 2              ; stderr
    mov rsi, ErrBuff
    mov rdx, ErrBuffLen
    syscall
    mov rax, 60             ; sys_exit
    mov rdi, -1             ; error
    syscall

Exit:   ret