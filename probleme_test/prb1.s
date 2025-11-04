.data 
    v: .space 25
    n: .long 5
    prompt: .asciz "Indexul este %d, iar numarul este %d\ iar n este %d\n"

.text
.global main
main:
    movl $v, %edi
    movl $11, %edx
    movl $0, %ecx

et_loop:
    cmp n, %ecx
    jg et_exit

    push n
    push %edx
    push %ecx
    push $prompt
    call printf
    pop %ebx
    pop %ecx
    pop %edx
    pop %ebx


    movl %edx, (%edi, %ecx, 4)
    inc %ecx
    inc %edx
    jmp et_loop


et_exit:
    movl $1, %eax
    xor %ebx, %ebx
    int $0x80

