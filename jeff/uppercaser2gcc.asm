SECTION .bss
    BUFFLEN equ 128
    Buff: resb BUFFLEN

SECTION .data

SECTION .text
global main
main:
    mov rbp, rsp                ; for correct debugging
    
Read:
    mov rax,0                   ; sys_read
    mov rdi,0                   ; stdin
    mov rsi,Buff                ; buffer offset address
    mov rdx,BUFFLEN             ; number of bytes to read per pass
    syscall                     ; fill the buffer
    mov r12,rax                 ; store number of bytes read, returned from sys_read syscall
    cmp rax,0                   ; 0 means no bytes read i.e. rax=0=>EOF
    je Done

    ; setup loop buffers    
    mov rbx,rax                 ; copy number of bytes read to rbx
    mov r13,Buff                ; put address of buffer in r13
    dec r13                     ; adjust for off-by-one
    
    ; iterate buffer and convert to upper
Scan:
    cmp byte [r13+rbx],61h      ; test input against 'a'
    jb .Next
    cmp byte [r13+rbx],7Ah      ; test input against 'z'
    ja .Next
    sub byte [r13+rbx],20h      ; convert to upper
.Next:
    dec rbx
    cmp rbx,0
    jnz Scan

    ; write the processed buffer
Write:
    mov rax,1                   ; sys_write
    mov rdi,1                   ; stdout
    mov rsi,Buff                ; buffer offset address
    mov rdx,r12                 ; number of bytes read in Read, returned from sys_read syscall
    syscall
    jmp Read

Done:   ret