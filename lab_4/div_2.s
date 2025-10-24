.data 
    x: .long 28
    y: .long 5

.text
.global main
    main:
        # x / y = 28 / 5 => c = 5, r = 3

        movl x,%eax
        movl $0,%edx
        divl y

    et_exit:
	    movl $1, %eax
	    movl $0, %ebx
	    int $0x80