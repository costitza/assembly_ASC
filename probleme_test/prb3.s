# media artimetica a unui vector de float 


.data
    v: .float 1.5, 2.32, 8.7, 4.6, 9.5
    n: .long 5
    printformat: .asciz "Rezulatatul este: %f\n"

.text
.global main
main:
    lea v, %edi
    movl n, %eax

    xorl %ecx, %ecx
    movl $0, %edx
    cvtsi2ss %edx, %xmm0


et_loop:
    cmp %ecx, n
    je medie

    movss (%edi, %ecx, 4), %xmm1
    addss %xmm1, %xmm0

    incl %ecx
    jmp et_loop

medie:
    cvtsi2ss n, %xmm1
    divss %xmm1, %xmm0

    cvtss2sd %xmm0, %xmm0
    subl $8, %esp
    movsd %xmm0, (%esp)

    push $printformat
    call printf

    addl $12, %esp


et_exit:
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80

