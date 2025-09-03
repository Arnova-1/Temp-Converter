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

    mov rax, 60 ; syscall: exit
    xor rdi, rdi 
    syscall

section .rodata
msg db "1. Celcius to Fahrenheit", 10, "2. Fahrenheit to Celcius", 10, "Please select one of the following operations: "
msg_len equ $ - msg 
