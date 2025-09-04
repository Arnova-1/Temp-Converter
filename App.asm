; App.asm
section .bss
opt resb 2 ; store operation number
value resb 64 ; store temp value

section .text
global _start
_start:
    mov rax, 1 ; syscall: write
    mov rdi, 1 ; fd: stdout
    mov rsi, msg ; pointer to msg 
    mov rdx, msg_len ; max bytes
    syscall

    xor rax, rax ; syscall: read
    xor rdi, rdi ; fd: stdin
    mov rsi, opt ; buffer address
    mov rdx, 2 ; newline counted
    syscall

    mov al, [opt] ; al = inputted operation

    cmp al, '0'
    je exit ; if al == '0' { exit }
    ; if al == '1' || al == '2' { valid }
    cmp al, '1'  
    je valid 
    cmp al, '2' 
    je valid
    jmp invalid ; else { ... }

valid:
    mov rax, 1 ; syscall: write
    mov rdi, 1
    mov rsi, prompt
    mov rdx, prompt_len
    syscall

    xor rax, rax ; syscall: read
    xor rdi, rdi
    mov rsi, value
    mov rdx, 64
    syscall

    ; begin parsing loop
    ; initialize result = 0, index = 0
    xor rbx, rbx ; result = 0 (rbx holds result)
    xor rcx, rcx ; index = 0 (rcx holds i)

parse_loop:
    mov ax, [value + rcx] ; load buffer[i]
    cmp ax, 10 ; compare with '\n' (ASCII 10)
    je parse_done ; jump to parse_done if newline, stop loop

    sub ax, '0' ; convert char to digit by substracting '0'-'9' or ASCII 48 - 57 with '0' or ASCII 48
    movzx rdx, ax ; move digit into rdx (zero-extended)

    mov rax, rbx ; copy result into rax
    imul rbx, rbx, 10 ; multiply rbx by 10 -> shift digit to left
    add rbx, rdx ; add the new digit

    inc rcx ; i++
    jmp parse_loop ; repeat

parse_done:
    cmp al, '1'
    je if_one
    cmp al, '2'
    je if_two

if_one:
    mov eax, 32
    cvtsi2ss xmm0, eax ; convert int to float
    cvtsi2ss xmm1, rbx
    movss xmm2, [c] ; load float to XMM register
    mulss xmm1, xmm2 ; xmm1 * 1.8
    addss xmm1, xmm0 ; xmm1 + 32
    movss [value], xmm1 ; store back to memory

if_two:
    mov eax, 32
    cvtsi2ss xmm0, eax
    cvtsi2ss xmm1, rbx
    movss xmm2, [c]
    subss xmm1, xmm2 ; xmm1 - 32
    divss xmm1, xmm2 ; xmm1 / 1.8
    movss [value], xmm1

invalid:
    mov rax, 1
    mov rdi, 1
    mov rsi, err
    mov rdx, err_len
    syscall
    jmp _start

exit:
    mov rax, 60 ; syscall: exit
    xor rdi, rdi 
    syscall

section .rodata
c db 1.8

msg db "========================", 10, " TEMPERATURE CONVERTER", 10, "========================", 10, "1. Celcius [°C] to Fahrenheit [°F]", 10, "2. Fahrenheit [°F] to Celcius [°C]", 10, "0. Exit", 10, "Please select one of the following operations: "
msg_len equ $ - msg

prompt db "Please enter the value that you want to convert: "
prompt_len equ $ - prompt

err db "Invalid input. Please enter 0, 1, or 2.", 10
err_len equ $ - err