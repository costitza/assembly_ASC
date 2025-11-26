
# Sa se scrie o procedura lenght, care primeste adresa unui sir de carctere si returneaza lungimea acestuia

.data 
    str: .asciz "Sir de caractere"
    formatPrint: .asciz "Lungimea sirului este %d\n"

.text
.global main
main:
    push $str
    call length
    add $4, %esp

    # printf 
    push %eax
    push $formatPrint
    call printf
    add $8, %esp


length:
    push %ebp
    mov %esp, %ebp
    xorl %eax, %eax
    push %edi
    mov 8(%ebp), %edi
length_loop:
    movb (%edi, %eax, 1), %cl
    cmpb $0, %cl
    je length_exit

    inc %eax
    jmp length_loop
length_exit:
    pop %edi
    pop %ebp
    ret
