.data
	x: .long 10
	y: .long 20
	str1: .asciz "x >= y\n" #8B
	str2: .asciz "x < y\n"	#7B
.text

.global main
main:
	mov x, %eax
	cmp y, %eax
	jge et1
	jmp et2

et1:
	mov $4, %eax
	mov $1, %ebx
	mov $str1, %ecx
	mov $8, %edx
	int $0x80
	jmp et_exit

et2:
	mov $4, %eax
	mov $1, %ebx
	mov $str2, %ecx
	mov $7, %edx
	int $0x80


et_exit:
	mov $1, %eax
	mov $0, %ebx
	int $0x80
