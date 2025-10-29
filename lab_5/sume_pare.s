/*

Facem suma dintr-un array a numerelor pare

*/

.data
    v: .long 3, 24, 5, 9, 6, 21, 8
    n: .long 7
    sum: .space 4
    prompt: .asciz "Suma din array este %d\n"

.text
.global main
main:
    movl $v, %edi
    movl $0, %ecx    # indexul din for
    movl $2, %esi

    movl $0, %ebx   # suma 

et_while:
    cmp n, %ecx
    je et_while_exit

    movl (%edi, %ecx, 4), %eax
    movl $0, %edx
    divl %esi
    cmp $0, %edx
    je is_even
et_while_cont:
    inc %ecx
    jmp et_while


is_even:
    movl (%edi, %ecx, 4), %eax
    add %eax, %ebx
    jmp et_while_cont

et_while_exit:
    movl %ebx, sum

et_exit:

    push sum
    push $prompt
    call printf
    pop %ebx
    pop %ebx

    movl $1, %eax
    movl $0, %ebx
    int $0x80
