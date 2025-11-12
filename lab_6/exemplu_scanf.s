.data
    formatScanf: .asciz "%d"
    x: .space 4
    formatPrint: .asciz "Am citit %d\n"

.text
.global main
main:
    # scanf
    push $x
    push $formatScanf
    call scanf
    add $8, %esp

    # printf
    push x
    push $formatPrint
    call printf
    add $8, %esp

et_exit:
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80



