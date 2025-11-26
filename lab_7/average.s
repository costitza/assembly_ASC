# calculam media aritmetica a unui array de floaturi

.data
    v: .float 0.1, 0.3, 0.5
    n: .long 3
    formatPrint: .asciz "Media artimetica este: %f\n"

.text
.global main:
main:
    lea v, %edi
    xorl %ecx, %ecx
    cvtsi2ss %ecx, %xmm0 # suma
et_loop:
    cmp n,%ecx
    je et_loop_exit

    movss (%edi, %ecx, 4), %xmm1
    addss %xmm1, %xmm0

    incl %ecx
    jmp et_loop

et_loop_exit:
    cvtsi2ss %ecx, %xmm1
    divss %xmm1, %xmm0 # xmm0 / xmm1

    sub $12, %esp
    movl $formatPrint, 0(%esp)
    cvtss2sd %xmm0, %xmm0
    movsd %xmm0, 4(%esp)
    call printf
    add $12, %esp

et_exit:
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
