.data 
    x: .long 5

.text
.global main
    main:
        mov $4, %eax
        movl x, %ebx
        mul %ebx

    et_exit:
	    mov $1, %eax
	    mov $0, %ebx
	    int $0x80