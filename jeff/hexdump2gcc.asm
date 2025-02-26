SECTION .bss
    BUFFLEN equ 10h
    Buff: resb BUFFLEN

SECTION .data
DumpLine:       db " 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
DUMPLEN         EQU $-DumpLine
ASCLine:        db "|................|",10 ; 10 is linefeed
ASCLEN          EQU $-ASCLine
FULLLEN         EQU $-DumpLine

; Index each nybble [HexDigitx+eax]
HexDigits:      db "0123456789ABCDEF"

; Printable characters are maintained. High 128 and non-printable are a period (2Eh)
DotXlat: 
    db 2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh
    db 2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh
    db 20h,21h,22h,23h,24h,25h,26h,27h,28h,29h,2Ah,2Bh,2Ch,2Dh,2Eh,2Fh
    db 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h,3Ah,3Bh,3Ch,3Dh,3Eh,3Fh
    db 40h,41h,42h,43h,44h,45h,46h,47h,48h,49h,4Ah,4Bh,4Ch,4Dh,4Eh,4Fh
    db 50h,51h,52h,53h,54h,55h,56h,57h,58h,59h,5Ah,5Bh,5Ch,5Dh,5Eh,5Fh
    db 60h,61h,62h,63h,64h,65h,66h,67h,68h,69h,6Ah,6Bh,6Ch,6Dh,6Eh,6Fh
    db 70h,71h,72h,73h,74h,75h,76h,77h,78h,79h,7Ah,7Bh,7Ch,7Dh,7Eh,2Eh
    db 2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh
    db 2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh
    db 2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh
    db 2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh
    db 2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh
    db 2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh
    db 2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh
    db 2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh

SECTION .text

; Clear a hexdump line string to 16 zeros by calling DumpChar 16 times
ClearLine:
    push rax                        ; backup all the r-x registers
    push rbx
    push rcx
    push rdx
    mov rdx,15                      ; counter for poke
.poke:
    mov rax,0
    call DumpChar
    sub rdx,1                       ; decrement counter, doesn't affect CF
    jae .poke

    pop rdx                         ; restore all the r-x registers
    pop rcx
    pop rbx
    pop rax
    ret

; Poke a character into hex dump line string
DumpChar:
    push rbx
    push rdi
    
    mov bl,[DotXlat+rax]
    mov [ASCLine+rdx+1],bl
    
    mov rbx,rax
    lea rdi,[rdx*2+rdx]
    
    and rax,000000000000000Fh
    mov al,[HexDigits+rax]
    mov [DumpLine+rdi+2],al
    
    and rbx,00000000000000F0h
    shr rbx,4
    mov bl,[HexDigits+rbx]
    mov [DumpLine+rdi+1],bl
    
    pop rdi
    pop rbx
    ret

PrintLine:
    push rax
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi
        
    mov rax,1                       ; sys_write
    mov rdi,1                       ; stdout
    mov rsi,DumpLine                ; Pass address of line string
    mov rdx,FULLLEN                 ; Pass size of the line string
    syscall
 
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret

LoadBuff:
    push rax
    push rdx
    push rsi
    push rdi
    
    mov rax,0                       ; sys_read
    mov rdi,0                       ; stdin
    mov rsi,Buff
    mov rdx,BUFFLEN
    syscall
    mov r15,rax                     ; save bytes read
    xor rcx,rcx
    
    pop rdi
    pop rsi
    pop rdx
    pop rax
    ret
    

GLOBAL main
main:
    mov rbp,rsp                    ; for correct debugging
    xor r15,r15
    xor rsi,rsi
    xor rcx,rcx
    call LoadBuff
    cmp r15,0                       ; exit if no more bytes read
    jbe Exit

Scan:
    xor rax,rax
    mov al,[Buff+rcx]               ; get byte from buffer to al
    mov rdx,rsi                     ; copy counter to rdx
    and rdx,000000000000000Fh       ; mask out all but lower 4 bits of char counter
    call DumpChar
    
    ; increas buffer counter and see if we are done
    inc rsi
    inc rcx
    cmp rcx,r15
    jb .modTest                     ; if buffer exhausted...
    call LoadBuff                   ; ... load it again
    cmp r15,0                       ; check if we are EOF
    jbe Done

.modTest:
    test rsi,000000000000000Fh
    jnz Scan                        ; if the counter is not % 16 loop back
    call PrintLine                  ; print the buffer
    call ClearLine                  ; clear to zeros
    jmp Scan

Done:
    call PrintLine                  ; any dangling buffer
Exit:
    mov rsp,rbp
    pop rbp
    ret