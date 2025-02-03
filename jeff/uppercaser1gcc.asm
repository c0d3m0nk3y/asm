; Converts all lowercase to uppercase
; ./uppercaser > output < input

section .bss
    Buff resb 1

section .data

section .text
global main
main:
    mov rbp, rsp

Read:
    mov rax, 0              ; sys_read
    mov rdi, 0              ; std_in
    mov rsi, Buff           ; address of buffer
    mov rdx, 1              ; tell sys_read to read 1 character from stdin
    syscall
    
    cmp rax, 0              ; check sys_read return value
    je Exit                 ; 0 means EOF
    
    cmp byte [Buff], 61h    ; compare buffer to 'a'
    jb Write                ; jump to Write if lower
    cmp byte [Buff], 7Ah    ; compare buffer to 'z'
    ja Write                ; jump to Write if higher
    
    sub byte [Buff], 20h    ; subtract 0x20, converts lowercase ASCII to upper
    
Write:
    mov rax, 1              ; sys_write
    mov rdi, 1              ; stdout
    mov rsi, Buff           ; address of character to write
    mov rdx, 1              ; number of characters to write
    syscall
    jmp Read                ; get the next character
    
Exit:   ret