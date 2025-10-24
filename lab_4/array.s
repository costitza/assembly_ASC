.data
    v: .long 2, 4, 6, 8
    n: .long 4
    sum: .space 4

.text
.global main

    main: 
        mov $v,%edi
    
        mov $0,%ecx
        mov $0,%eax

    while:
        cmp n,%ecx
        je while_exit

        movl (%edi, %ecx, 4), %ebx  # ebx este elementul curent
        add %ebx, %eax 

        inc %ecx
        jmp while
    
    while_exit:
        movl %eax, sum
    
    et_exit:
	    movl $1, %eax
	    movl $0, %ebx
	    int $0x80