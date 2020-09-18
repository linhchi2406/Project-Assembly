.eqv KEY_CODE 0xFFFF0004 	# ASCII code from keyboard, 1 byte
.eqv KEY_READY 0xFFFF0000 	# =1 if has a new keycode ?
 				# Auto clear after lw
.eqv DISPLAY_CODE 0xFFFF000C 	# ASCII code to show, 1 byte
.eqv DISPLAY_READY 0xFFFF0008 	# =1 if the display has already to do
 				# Auto clear after sw
.text
 	li $k0, KEY_CODE
 	li $k1, KEY_READY

 	li $s0, DISPLAY_CODE
 	li $s1, DISPLAY_READY
loop: nop
Wait_e:
	        jal WaitForKey
	        subi $t3, $t0, 101
	        bne $t3,$zero,Wait_e
Wait_x:
		jal WaitForKey
	        subi $t3, $t0, 120
	        bne $t3,$zero,Wait_e
Wait_i:
		jal WaitForKey
	        subi $t3, $t0, 105
	        bne $t3,$zero,Wait_e
Wait_t:
		jal WaitForKey
	        subi $t3, $t0, 116
	        bne $t3,$zero,Wait_e
	        
	        li $v0,10
	        syscall

	         
WaitForKey: 	lw $t1, 0($k1) 	# $t1 = [$k1] = KEY_READY
            	beq $t1, $zero, WaitForKey 	# if $t1 == 0 then Polling
ReadKey: 	lw $t0, 0($k0) # $t0 = [$k0] = KEY_CODE
WaitForDis: 	lw $t2, 0($s1) # $t2 = [$s1] = DISPLAY_READY
 		beq $t2, $zero, WaitForDis # if $t2 == 0 then Polling
Encrypt: 	addi $t4, $t0, 1 # change input key
ShowKey: 	sw $t4, 0($s0) # show key
		nop
		jr $ra
 		