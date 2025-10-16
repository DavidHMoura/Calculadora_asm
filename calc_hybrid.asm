global main
extern printf
extern scanf
extern getchar
extern ungetc
extern stdin

section .data
    prompt      db "Digite: <num> <op> <num> (ou q pra sair): ", 0
    scan_fmt    db "%lf %c %lf", 0
    result_fmt  db "Resultado: %.4lf", 10, 0
    err_div0    db "Erro: divisao por zero", 10, 0
    bye_msg     db "Saindo... valeu!", 10, 0

section .bss
    a   resq 1        
    b   resq 1
    op  resb 1        
section .text
main:
    push rbp
    mov rbp, rsp

.loop:
    lea rdi, [rel prompt]
    xor eax, eax
    call printf

.read_first:
    call getchar           
    movzx eax, al          
    cmp al, 9            
    je .read_first
    cmp al, 10            
    je .read_first
    cmp al, 13            
    je .read_first
    cmp al, 32            
    je .read_first

    cmp al, 'q'
    je .quit
    cmp al, 'Q'
    je .quit
   
    mov edi, eax           
    mov rsi, [rel stdin]
    xor eax, eax
    call ungetc

    lea rdi, [rel scan_fmt]
    lea rsi, [rel a]
    lea rdx, [rel op]
    lea rcx, [rel b]
    xor eax, eax
    call scanf
   
    movsd xmm0, [a]   
    movsd xmm1, [b]    

   
    movzx r10d, byte [op]

    cmp r10d, '+' 
    je .do_add
    cmp r10d, '-'
    je .do_sub
    cmp r10d, '*'
    je .do_mul
    cmp r10d, '/'
    je .do_div

    jmp .loop

.do_add:
    addsd xmm0, xmm1
    jmp .print_result

.do_sub:
    subsd xmm0, xmm1
    jmp .print_result

.do_mul:
    mulsd xmm0, xmm1
    jmp .print_result

.do_div:
    xorpd xmm2, xmm2       
    ucomisd xmm1, xmm2     
    jp .div_nan           
    je .div_zero
    divsd xmm0, xmm1
    jmp .print_result

.div_zero:
    lea rdi, [rel err_div0]
    xor eax, eax
    call printf
    jmp .loop

.div_nan:
    lea rdi, [rel err_div0]
    xor eax, eax
    call printf
    jmp .loop

.print_result:
    lea rdi, [rel result_fmt]
    movsd xmm1, xmm0
    mov eax, 1
    call printf
    jmp .loop

.quit:
    lea rdi, [rel bye_msg]
    xor eax, eax
    call printf

    mov rsp, rbp
    pop rbp
    mov eax, 0
    ret
