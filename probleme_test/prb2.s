# calculam aria unui cerc (ARIA = pi * raza ^ 2)

.data 
    pi: .float 3.14159
    rad: .float 0.0
    arie: .float 0.0
    promptscanf: .asciz "%f"
    promptprintf: .asciz "rezultat: %f\n"

.text
.global main

main:

    pushl $rad
    push $promptscanf
    call scanf

    addl $8, %esp

    pushl rad
    pushl pi
    call radius

    addl $8, %esp


et_exit:
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80


radius:
    pushl %ebp
    movl %esp, %ebp

    movss 8(%ebp), %xmm0
    movss 12(%ebp), %xmm1

    mulss %xmm1, %xmm1

    mulss %xmm1, %xmm0

    subl $8, %esp
    cvtss2sd %xmm0, %xmm1
    movsd %xmm1, 0(%esp)
    push $promptprintf
    call printf

    addl $12, %esp



    popl %ebp
    ret

