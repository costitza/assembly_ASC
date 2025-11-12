.data 
    x: .space 4
    y: .space 4
    formatScanf: .asciz "%d"
    formatPrint: .asciz "Suma este: %d\n"

.text
.global main
main: 
    # scanf x
    pushl $x
    pushl $formatScanf
    call scanf
    addl $8, %esp

    # scanf y
    pushl $y
    pushl $formatScanf
    call scanf
    addl $8, %esp

    push y
    push x
    call sum
    add $8, %esp


    pushl %eax
    pushl $formatPrint
    call printf
    add $8, %esp
    # %eax este rezultatul

sum: 
    # (<r.a>)(x)(y)
    push %ebp
    mov %esp, %ebp
    mov 8(%ebp), %eax
    push %ebx
    mov 12(%ebp), %ebx
    add %ebx, %eax
    
    pop %ebx
    pop %ebp
    ret

et_exit:
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80