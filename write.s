.data
	str: .asciz "Hello, world!\n"
.text

.global main
main:
	mov $4, %eax
	mov $1, %ebx
	mov $str, %ecx	#ce scriem
	mov $15, %edx	#cat scriem (cati Bytes)
	int $0x80

et_exit:
	mov $1, %eax
	mov $0, %ebx
	int $0x80
