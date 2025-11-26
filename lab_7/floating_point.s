.data 
    x: .float -2075.3125
    formatPrint: "valoarea lui x este: %f\n"
.text
.global main
main:
    movss x, %xmm0
    # facem printf
    sub $12, %esp
    mov $formatPrint, 0(%esp)
    
    cvtss2sd %xmm0, %xmm0
    movsd %xmm0, 4(%esp)
    call printf
    add $12, %esp

et_exit:
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80