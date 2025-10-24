.data
    v: .long 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    n: .long 10
    sum: .space 4
    imp: .long 2

.text
.global main

main: 
    mov $v,%edi

    mov $0,%ecx
    mov $0,%eax

while:
    cmp n,%ecx
    je while_exit

    # luam elementele in suma numa pare

    movl (%edi, %ecx, 4), %eax  # eax este elementul curent
    movl $0,%edx
    divl $imp

    cmp $0,%edx
    je et_sum

    inc %ecx
    jmp while

while_cont:
    inc %ecx
    jmp while

et_sum:
    movl (%edi, %ecx, 4), %eax
    add %eax, %ebx
    jmp while_cont

while_exit:
    movl %ebx, sum

et_exit:
    movl $1, %eax
    movl $0, %ebx
    int $0x80