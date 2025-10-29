/*

fiind dat un sir de caracatere in sectiunea data, sa se determine
numarul de vocale

*/

.data
    str: .asciz "Sir de caractere"
    count: .long 0
    formatprint: .asciz "Numarul de vocale este %d\n"

.text
.global main
main:
    movl $str, %edi
    movl $0, %ecx
    movl $0, %ebx
    movl $0, count

et_while: 
    movb (%edi, %ecx, 1), %al
    cmpb $0, %al
    je et_exit

    cmpb $'a',%al
    je is_vowel
    cmpb $'e',%al
    je is_vowel
    cmpb $'i',%al
    je is_vowel
    cmpb $'o',%al
    je is_vowel
    cmpb $'u',%al
    je is_vowel
et_while_cont:
    incl %ecx
    jmp et_while

is_vowel:
    incl count
    jmp et_while_cont

et_exit:

    push count
    push $formatprint
    call printf
    pop %ebx
    pop %ebx

    movl $1, %eax
    movl $0, %ebx
    int $0x80

