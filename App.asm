; App.asm
section .data
msg db "1. Celcius to Fahrenheit", 10, "2. Fahrenheit to Celcius", 10, "Please select one of the operations: "
msg_len equ $ - msg 

section .text
global _start
_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, msg_len
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall
