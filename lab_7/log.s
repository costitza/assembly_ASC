# calculam logaritmul natural al unui numar


.data
    x: .float 2.718281828
    formatPrint: .asciz "Log(x) = %f\n"

.text
.global main
main:
    sub $4, %esp
    movss x, %xmm0
    movss %xmm0, 0(%esp)
    call logf
    add $4, %esp


    fstps y
    movss y, %xmm0
    cvtss2sd %xmm0, %xmm0

    sub $12, %esp
    movl $formatPrint, 0(%esp)
    movsd %xmm0, 4(%esp)
    call printf
    add %12, %esp

et_exit:
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
