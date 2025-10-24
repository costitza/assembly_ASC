.data 
    x: .long 16

.text
.global main
    main:
        movl $8, %edx
        movl $0, %eax


        divl x


    et_exit:
	    movl $1, %eax
	    movl $0, %ebx
	    int $0x80