.data
	x: .long 10
	y: .long 20
	sum: .space 4

.text

.global main

main:
	mov x, %eax
	add y, %eax
	mov %eax, sum



et_exit:
	mov $1, %eax
	mov $0, %ebx
	int $0x80
	