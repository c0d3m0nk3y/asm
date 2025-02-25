; USAGE: xlat1gcc < input > output

SECTION .data
    StatMsg: db "Processing...",10
    StatLen: equ $-StatMsg
    DoneMsg: db "...done",10
    DoneLen: equ $-DoneMsg

    UpCase:
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,09h,0Ah,20h,20h,20h,20h,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
    db 20h,21h,22h,23h,24h,25h,26h,27h,28h,29h,2Ah,2Bh,2Ch,2Dh,2Eh,2Fh
    db 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h,3Ah,3Bh,3Ch,3Dh,3Eh,3Fh
    db 40h,41h,42h,43h,44h,45h,46h,47h,48h,49h,4Ah,4Bh,4Ch,4Dh,4Eh,4Fh
    db 50h,51h,52h,53h,54h,55h,56h,57h,58h,59h,5Ah,5Bh,5Ch,5Dh,5Eh,5Fh
    db 60h,41h,42h,43h,44h,45h,46h,47h,48h,49h,4Ah,4Bh,4Ch,4Dh,4Eh,4Fh
    db 50h,51h,52h,53h,54h,55h,56h,57h,58h,59h,5Ah,7Bh,7Ch,7Dh,7Eh,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h

    ; replace | with !
    Custom: 
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,09h,0Ah,20h,20h,20h,20h,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
    db 20h,21h,22h,23h,24h,25h,26h,27h,28h,29h,2Ah,2Bh,2Ch,2Dh,2Eh,2Fh
    db 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h,3Ah,3Bh,3Ch,3Dh,3Eh,3Fh
    db 40h,41h,42h,43h,44h,45h,46h,47h,48h,49h,4Ah,4Bh,4Ch,4Dh,4Eh,4Fh
    db 50h,51h,52h,53h,54h,55h,56h,57h,58h,59h,5Ah,5Bh,5Ch,5Dh,5Eh,5Fh
    db 60h,61h,62h,63h,64h,65h,66h,67h,68h,69h,6Ah,6Bh,6Ch,6Dh,6Eh,6Fh
    db 70h,71h,72h,73h,74h,75h,76h,77h,78h,79h,7Ah,7Bh,21h,7Dh,7Eh,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h

SECTION .bss
    READLEN equ 1024
    ReadBuffer: resb READLEN

SECTION .text
global main
main:
    mov rbp,rsp                     ; for gdb

    ; Write "Processing..." message to stderr
    mov rax,1                       ; sys_write
    mov rdi,2                       ; stderr
    mov rsi,StatMsg
    mov rdx,StatLen
    syscall

; read a buffer full of text from stdin    
read:
    mov rax,0                       ; sys_read
    mov rdi,0                       ; stdin
    mov rsi,ReadBuffer              ; pass the buffer address
    mov rdx,READLEN                 ; number of bytes to read per pass
    syscall
    mov rbp,rax                     ; save number of bytes read
    cmp rax,0                       ; if no bytes read we are done...
    je done

    ; set up registers
    mov rbx,Custom                  ; put the table in RBX
    mov rdx,ReadBuffer
    mov rcx,rbp                     ; number of bytes from sys_read for buffer offset stepping backwards

; step backwards through the buffer, translating each character
translate:
    xor rax,rax
    mov al,byte [rdx-1+rcx]         ; load a character into AL for xlat
    xlat                            ; translates character in AL from table in RBX
    mov byte [rdx-1+rcx],al         ; put the translated character back into the buff
    dec rcx                         ; decrement the buffer offset
    jnz translate                   ; keep going until buffer is exhausted

; write the buffer to stdout
write:
    mov rax,1                       ; sys_write
    mov rdi,1                       ; stdout
    mov rsi,ReadBuffer
    mov rdx,rbp                     ; number of bytes read by sys_read
    syscall
    jmp read

; display done message and return
done:
    ; Write "...done" message to stderr
    mov rax,1                       ; sys_write
    mov rdi,2                       ; stderr
    mov rsi,DoneMsg
    mov rdx,DoneLen
    syscall

    ret