; hexdump1gcc < file

SECTION .bss
    BUFFLEN equ 16
    Buff: resb BUFFLEN

SECTION .data
    HexStr: db " 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00", 10
    HEXLEN equ $-HexStr
    Digits: db "0123456789ABCDEF"

SECTION .text
global main
main:
    mov rbp, rsp                ; for correct debugging

; read a line of text from stdin to the buffer
Read:
    mov rax,0                   ; sys_read
    mov rdi,0                   ; stdin
    mov rsi,Buff                ; offset of buffer to read to
    mov rdx,BUFFLEN             ; number of bytes to read
    syscall
    mov r15,rax                 ; save # of bytes read from file
    cmp rax,0                   ; check EOF
    je Done

    ; set up the registers for the process buffer step:parm
    mov rsi,Buff                ; address of file buffer into esi
    mov rdi,HexStr              ; address of line string into edi
    xor rcx,rcx                 ; zero rcx for use as counter

; iterate buffer character at a time and convert binary values to hex digits
Scan:
    xor rax,rax                 ; zero rax
    
    ; calculate offset into line string, rcx * 3
    mov rdx,rcx
    ;shl rdx,1
    ;add rdx,rcx
    lea rdx,[rdx*2+rdx]
    
    ; get a character from the buffer, put in rax and rbx
    mov al,byte [rsi+rcx]       ; put a byte from input buffer to al
    mov rbx,rax                 ; duplicate to bl for second nybble
    
    ; look at low nybble character and instert it into the string
    and al,0Fh                  ; mask high nybble
    mov al,byte [Digits+rax]    ; look up character equivalent of the nybble
    mov byte [HexStr+rdx+2],al  ; write character equivalent to the line string
    
    ; look at high nybble character and insert it into the string
    shr bl,4                    ; shift high nybble to low nybble
    mov bl,byte [Digits+rbx]    ; look up character equivalent of the nybble
    mov byte [HexStr+rdx+1],bl  ; write character equivalent to the line string
    
    ; bump buffer pointer to next character and see if done
    inc rcx
    cmp rcx,r15
    jna Scan
    
    ; write the line of hex to stdout
    mov rax,1                   ; sys_write
    mov rdi,1                   ; stdout
    mov rsi,HexStr
    mov rdx,HEXLEN
    syscall
    jmp Read

Done:   ret