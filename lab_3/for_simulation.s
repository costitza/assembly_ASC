.data
	n: .long 10
.text

.global main
main:
	movl 0, %ecx

et_while:
    cmp n, %ecx
    je et_exitwhile
    inc %ecx

    jmp et_while

et_exitwhile:

et_exit:
	mov $1, %eax
	mov $0, %ebx
	int $0x80

et_adaugat:
	
