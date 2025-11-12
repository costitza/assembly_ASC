# sa se calc suma elem dintrun array de maxim 20 de elem
# se va citi arrayul de la STDIN


.data 
    n: .space 4
    v: .space 80
    x: .space 4
    formatScanf: .asciz "%d"
    formatPrint: .asciz "Suma este: %d\n"

.text
.global main
main: 
    # scanf x
    pushl $n
    pushl $formatScanf
    call scanf
    addl $8, %esp

    lea v, %edi
    movl $0, %ecx

et_for:
    cmp n, %ecx
    je et_for_exit

    push %ecx
    push $x
    push $formatScanf
    call scanf
    addl $8, %esp
    pop %ecx

    movl x, %esi
    movl %esi, (%edi, %ecx, 4)

    inc %ecx
    jmp et_for


et_for_exit:

    push n
    push $v
    call sum_array
    add $8, %esp


    pushl %eax
    pushl $formatPrint
    call printf
    add $8, %esp
    # %eax este rezultatul

sum_array:
    # (<r.a>)(v)(n)

    push %ebp
    mov %esp, %ebp
    movl 12(%ebp), %edx     # numarul de elemente
    push %edi

    movl 8(%ebp), %edi
    xorl %ecx, %ecx
    xorl %eax, %eax
    pushl %ebx

sum_array_for:
    cmp %edx, %ecx
    je sum_array_for_exit

    movl (%edi, %ecx, 4), %ebx
    addl %ebx, %eax


    inc %ecx
    jmp sum_array_for

sum_array_for_exit:
    pop %ebx
    pop %edi
    pop %ebp
    ret

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