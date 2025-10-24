.data
	str1: .asciz "Sir 1\n"
	str2: .asciz "Sir 2\n"
.text

.global main
main:
	jmp et2
et1:
	mov $4, %eax
	mov $1, %ebx
	mov $str1, %ecx
	mov $7, %edx
	int $0x80

	jmp et_exit

et2:
	mov $4, %eax
	mov $1, %ebx
	mov $str2, %ecx
	mov $7, %edx
	int $0x80

	jmp et1

et_exit:
	mov $1, %eax
	mov $0, %ebx
	int $0x80
