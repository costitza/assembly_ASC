# Facem suma 1 + 2 + ... + n

.data
    n: .long 15
    sum: .space 4

.text

.global main
main:
    mov $0, %ecx
    mov $0, %eax

et_loop:
    cmp n, %ecx
    je et_exit

    add %ecx, %eax
    inc %ecx
    jmp et_loop

et_exit:
    movl %eax, sum
    mov $1, %eax
	mov $0, %ebx
	int $0x80
