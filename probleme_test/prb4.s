# calcul entropie

.data
    probs: .float 0.5, 0.25, 0.25
    n: .long 3
    format: .asciz "Entropia (SIMD mix): %f\n"

.text
.global main
main:

    lea probs, %edi
    xorl %ecx, %ecx
    movl n, %eax
    cvtsi2ss %ecx, %xmm0

et_for:
    cmp %ecx, %eax
    je exit_for 

    movss (%edi, %ecx, 4), %xmm1
    pushl %ecx
    pushl %eax

    subl $4, %esp
    movss %xmm0, (%esp)

    subl $4, %esp
    movss %xmm1, (%esp)
    call log2f
    addl $4, %esp

    movss (%esp), %xmm0
    addl $4, %esp

    popl %eax
    popl %ecx

    movss (%edi, %ecx, 4), %xmm1

    subl $4, %esp
    fstps (%esp)

    movss (%esp), %xmm2
    addl $4, %esp

    mulss %xmm2, %xmm1
    subss %xmm1, %xmm0


    incl %ecx
    jmp et_for

exit_for:
    
    cvtss2sd %xmm0, %xmm0
    subl $8, %esp
    movsd %xmm0, (%esp)
    push $format
    call printf
    addl $12, %esp


et_exit:
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80

