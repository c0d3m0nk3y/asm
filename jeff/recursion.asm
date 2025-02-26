SECTION .bss

SECTION .data

SECTION .text
global main
main:
    mov rbp, rsp                ; for correct debugging
    
    xor rax,rax
    mov rax,10
    call Recurse
    jmp Done
    
Recurse:
    dec rax
    cmp rax,0
    jne Recurse
    ret

Done:   ret