.intel_syntax noprefix
.global _start

.section .text

_start:
    mov rax, 41
    mov rdi, 2
    mov rsi, 1
    xor rdx, rdx
    syscall
    
    mov rbx, rax

    mov rax, 49
    mov rdi, rbx
    lea rsi, [rip+sockaddr]
    mov rdx, 16
    syscall

    mov rax, 50
    mov rdi, rbx
    xor rsi, rsi
    syscall

server_loop:
    mov rax, 43
    mov rdi, rbx
    xor rsi, rsi
    xor rdx, rdx
    syscall
    
    mov r12, rax

    mov rax, 57
    syscall
    cmp rax, 0
    je child_path

parent_path:
    mov rax, 3
    mov rdi, r12
    syscall
    jmp server_loop

child_path:
    mov rax, 3
    mov rdi, rbx
    syscall

    mov rax, 0
    mov rdi, r12
    lea rsi, [rip+request_buf]
    mov rdx, 1024
    syscall
    mov r15, rax

    lea rsi, [rip+request_buf]
    mov al, byte ptr [rsi]
    cmp al, 'G'
    je handle_get
    cmp al, 'P'
    je handle_post
    jmp done

handle_get:
    lea rsi, [rip+request_buf+4]
    mov r13, rsi

get_path_loop:
    mov al, byte ptr [rsi]
    cmp al, ' '
    je get_path_done
    cmp al, 0
    je get_path_done
    inc rsi
    jmp get_path_loop

get_path_done:
    mov byte ptr [rsi], 0

    mov rax, 2
    mov rdi, r13
    xor rsi, rsi
    syscall
    mov r13, rax

    mov rax, 0
    mov rdi, r13
    lea rsi, [rip+file_buf]
    mov rdx, 4096
    syscall
    mov r14, rax

    mov rax, 3
    mov rdi, r13
    syscall

    mov rax, 1
    mov rdi, r12
    lea rsi, [rip+response]
    mov rdx, 19
    syscall

    mov rax, 1
    mov rdi, r12
    lea rsi, [rip+file_buf]
    mov rdx, r14
    syscall
    jmp done

handle_post:
    lea rsi, [rip+request_buf]

skip_method:
    mov al, byte ptr [rsi]
    cmp al, ' '
    je skip_method_done
    inc rsi
    jmp skip_method

skip_method_done:
    inc rsi
    mov r13, rsi

post_path_loop:
    mov al, byte ptr [rsi]
    cmp al, ' '
    je post_path_done
    inc rsi
    jmp post_path_loop

post_path_done:
    mov byte ptr [rsi], 0

    mov rax, 2
    mov rdi, r13
    mov rsi, 65
    mov rdx, 0777
    syscall
    mov r13, rax

    lea rbx, [rip+request_buf]
    xor rcx, rcx

find_body:
    cmp rcx, r15
    jge no_body
    cmp byte ptr [rbx+rcx], 13
    jne next_char
    cmp byte ptr [rbx+rcx+1], 10
    jne next_char
    cmp byte ptr [rbx+rcx+2], 13
    jne next_char
    cmp byte ptr [rbx+rcx+3], 10
    jne next_char
    add rcx, 4
    jmp body_found

next_char:
    inc rcx
    jmp find_body

no_body:
    lea rsi, [rbx]
    xor rdx, rdx
    jmp write_body

body_found:
    lea rsi, [rbx+rcx]
    mov rdx, r15
    sub rdx, rcx

write_body:
    mov rax, 1
    mov rdi, r13
    syscall

    mov rax, 3
    mov rdi, r13
    syscall

    mov rax, 1
    mov rdi, r12
    lea rsi, [rip+response]
    mov rdx, 19
    syscall

done:
    mov rax, 3
    mov rdi, r12
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall

.section .data
sockaddr:
    .word 2
    .word 0x5000
    .long 0
    .quad 0

response:
    .ascii "HTTP/1.0 200 OK\r\n\r\n"

.section .bss
request_buf:
    .zero 1024
file_buf:
    .zero 4096
