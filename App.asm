; App.asm
section .bss
buffer resb 64 ; Store input

section .text
global _start
_start:
    mov rax, 1 ; syscall: write
    mov rdi, 1 ; fd: stdout
    mov rsi, msg
    mov rdx, msg_len
    syscall

    mov rax, 0 ; syscall: read
    mov rdi, 0 ; fd: stdin
    mov rsi, buffer ; buffer address
    mov rdx, 64 ; max bytes
    syscall
    ; rax = user input

    ; begin parsing loop
    ; initialize result = 0, index = 0
    xor rbx, rbx ; result = 0 (rbx holds result)
    xor rcx, rcx ; index = 0 (rcx holds i)

parse_loop:
    mov al, [buffer + rcx] ; load buffer[i]
    cmp al, 10 ; compare with '\n' (ASCII 10)
    je parse_done ; jump to parse_done if newline, stop loop

    sub al, '0' ; convert char to digit by substracting '0'-'9' or ASCII 48 - 57 with '0' or ASCII 48
    movzx rdx, al ; move digit into rdx (zero-extended)

    mov rax, rbx ; copy result into rax
    imul rbx, rbx, 10 ; multiply rbx by 10 -> shift digit to left
    add rbx, rdx ; add the new digit

    inc rcx ; i++
    jmp parse_loop ; repeat

    mov rax, 60 ; syscall: exit
    xor rdi, rdi 
    syscall

section .rodata
msg db "1. Celcius to Fahrenheit", 10, "2. Fahrenheit to Celcius", 10, "Please select one of the following operations: "
msg_len equ $ - msg 
