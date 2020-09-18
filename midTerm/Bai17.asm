.data
string:  	.space 1000
output:		.space 1000
Message: 	.asciiz "Nhap day so can giai ma: "
Message2: 	.asciiz "Ket qua giai ma la: "
InvalidCharInputMessage:  	.asciiz "Day so Nhap vao phai la day nhi phan!\n"
InvalidLengthMessage: 		.asciiz "Day so nhap vao phai co do dai chia het cho 8!\n"
InvalidValueMessage: 		.asciiz "Hay xem lai chuoi so. Dam bao chuoi so co cac ki tu hien thi duoc\n"
.text
#---------------------------------------------------------------------------------
# @get_string: nhan chuoi nhap vao tu ban phim
# @get_length: luu string vao thanh ghi $s0, duyet chuoi, validate dau vao 
#	      	$s0 luu dia chi co so cua chuoi input
#		#t7 la bien chay cua ky tu, sau get_length la do dai string (n)
#		$t1 dia chi cua ky tu	
#		$t2 luu gia tri cua ky tu, luu so du trong ham check_valid_length
# @decode: vong lap doi gia tri moi 8 bit thanh he dem 10 
#		$t0 bien chay cua ki tu trong chuoi input (i)
#		$s1 luu gia tri cua ky tu hien tai
# 		$t5 luu gia tri bit tuong ung cua ki tu hien tai
#		$s3 luu gia tri decode cua tung nhom 8 ky tu (sum)
#		$t3 luu bien chay cua output (j)
#		$s2 luu dia chi co so cua output
# @add_to_output(ham con cua decode): 
# 		bien nhom 8 ky tu tro thanh mot ki tu roi dua vao output
#		$t4 luu dia chi hien tai cua output
# @print_output	int ra chuoi da duoc giai ma
#---------------------------------------------------------------------------------

main:
# hien thi hop thoai yeu cau nguoi dung nhap vao string
get_string:	
	li $v0, 54
	la $a0, Message
	la $a1, string		#dua string vao $a1
	la $a2, 1000
	syscall
	beq $a1,-2,endmain
end_of_get_str:


# Duyet chuoi
get_length:	la  $s0,string			# $s0 = address(string[0])
		add $t7,$zero,$zero		# $t7 = n = 0
check_char: 	add $t1,$s0,$t7			# $t1 = $a0 + $t7 = address (string[n])
		lb $t2, 0($t1)			# $t2 = string[n]
	 	beq $t2, $zero, end_of_str	# $t2==null? j end_of_string | kiem tra ki tu 
		addi $t7,$t7,1			# $t0 += 1 =. n += 1
		beq $t2, 48, check_char		# $t2=='0'? j check_char | kiem tra '0' va '\n'
		beq $t2, 49, check_char		# $t2=='1'? j check_char | kiem tra '\n'
		beq $t2, 10, check_char		# $t2=='\n'? j check_char | bao loi InvalidCharInput
invalid_char_input_notice:			 
		li $v0, 4			
		la $a0, InvalidCharInputMessage	
		syscall	 
		j get_string   	 			
end_of_str:			
		addi $t7, $t7, -1		# $t7 tru di 1 de lay do dai chuoi khong tinh '\n'
end_of_get_length:				

# kiem tra do dai chuoi phai chia het cho 8
check_valid_length:
	addi $t3, $zero, 8		# $t3 = 8
	div $t7, $t3			# thuc hien phep chia
     	mfhi $t2 			# so du duoc luu vao $t2
	beq $t2, 0, decode		# $t2==0? decode | bao loi InvalidLengthNotice
invalid_length_notice:
	li $v0, 4			
	la $a0, InvalidLengthMessage	
	syscall	 
	j get_string   	 			

#thuc hien giai ma bang cach: Nhom tung nhom gom 8 ky tu, thuc hien xu ly doi sang he 10 sau do dua vao chuoi output
decode: 	
	#Khoi tao:
	addi $s3, $zero, 0
	addi $t0, $zero, -1 		# $t0 la bien chay cua input, $t0 = -1
	addi $t3, $zero, -1		# $t3 = 0, la bien chay cua ouput
	la $s2, output			# output duoc luu vao t hanh ghi $s2
	add $t5, $zero, $zero		# $t5 luu gia tri bit tuong ung cua ky tu
continue:
	addi $t0, $t0, 1		# $t0+=1 ; i++
	beq $t0, $t7, end		# $t0==n? j end | j func (tinh bit dau)
func1:
	add $t1, $s0, $t0		# $t1=address(string[i])
	lb $s1, 0($t1)			# $s1=string[i]
	beq $s1, 48, func2		# $s1=='0'? j func2 | gan $t5=1, tinh toan gia tri $s3
	addi $t5, $zero, 1		# gan $t5=1
	sll $t5, $t5, 7			# $t5 dich trai 7 bit
	add $s3, $s3, $t5		# sum += $t5  
	addi $t5, $zero, 0		# set lai gia tri $t5 = 0
func2:
	addi $t0, $t0, 1		# $t0+=1; i++
	add $t1, $s0, $t0		# $t1=address(string[i])
	lb $s1, 0($t1)			# $s1=string[i]
	beq $s1, 48, func3		# $s1=='0'? j func3 | gan $t5=1, tinh toan gia tri $s3
	addi $t5, $zero, 1		# $t5=1
	sll $t5, $t5, 6			# $t5 dich trai 6 bit
	add $s3, $s3, $t5		# sum += $t5
	addi $t5, $zero, 0			# set lai gia tri $t5=0
func3:
	addi $t0, $t0, 1		# $t0+=1; i++
	add $t1, $s0, $t0		# $t1=address(string[i])
	lb $s1, 0($t1)			# $s1=string[i]
	beq $s1, 48, func4		# $s1=='0'? j func4 | gan $t5=1, tinh toan gia tri $s3
	addi $t5, $zero, 1		# $t5=1
	sll $t5, $t5, 5			# $t5 dich trai 5 bit
	add $s3, $s3, $t5		# sum += $t5
	addi $t5, $zero, 0		# set lai gia tri $t5=0
func4:
	addi $t0, $t0, 1		# $t0+=1; i++
	add $t1, $s0, $t0		# $t1=address(string[i])
	lb $s1, 0($t1)			# $s1=string[i]
	beq $s1, 48, func5		# $s1=='0'? j func5 | gan $t5=1, tinh toan gia tri $s3
	addi $t5, $zero, 1		# $t5=1
	sll $t5, $t5, 4			# $t5 dich trai 4 bit
	add $s3, $s3, $t5		# sum += $t5
	addi $t5, $zero, 0		# set lai gia tri $t5
func5:
	addi $t0, $t0, 1		# $t0+=1; i++
	add $t1, $s0, $t0		# $t1=address(string[i])
	lb $s1, 0($t1)			# $s1=string[i]
	beq $s1, 48, func6		# $s1=='0'? j func6 | gan $t5=1, tinh toan gia tri $s3
	addi $t5, $zero, 1		# $t5=1
	sll $t5, $t5, 3			# $t5 dich trai 3 bit
	add $s3, $s3, $t5		# sum += $t5
	addi $t5, $zero, 0		# set lai gia tri $t5
func6:	
	addi $t0, $t0, 1		# $t0+=1; i++
	add $t1, $s0, $t0		# $t1=address(string[i])
	lb $s1, 0($t1)			# $s1=string[i]
	beq $s1, 48, func7		# $s1=='0'? j func7 | gan $t5=1, tinh toan gia tri $s3
	addi $t5, $zero, 1		# $t5=1
	sll $t5, $t5, 2			# $t5 dich trai 2 bit
	add $s3, $s3, $t5		# sum += $t5
	addi $t5, $zero, 0		# set lai gia tri $t5
func7:
	addi $t0, $t0, 1		# $t0+=1; i++
	add $t1, $s0, $t0		# $t1=address(string[i])
	lb $s1, 0($t1)			# $s1=string[i]
	beq $s1, 48, func8		# $s1=='0'? j func8 | gan $t5=1, tinh toan gia tri $s3
	addi $t5, $zero, 1		# $t5=1
	sll $t5, $t5, 1			# $t5 dich trai 1 bit
	add $s3, $s3, $t5		# sum += $t5
	addi $t5, $zero, 0		# set lai gia tri $t5
func8:	
	addi $t0, $t0, 1		# $t0 += 1; i++
	add $t1, $s0, $t0		# $t1=address(string[i])
	lb $s1, 0($t1)			# $s1=string[i]
	beq $s1, 48, check_output	# $s1=='0'? j check_output | gan $t5=1, tinh toan gia tri $s3
	addi $t5, $zero, 1		# $t5 dich trai 1 bit
	add $s3, $s3, $t5		# sum += $t5
	addi $t5, $zero, 0		# set lai gia tri $t5
	
# vi cac ky tu co the hien thi duoc trong bang ascii co gia tri tu 32 den 
# 126 nen can check xem sum $s3 co nam trong khoang nay khong
check_output:
 	slti $t2, $s3, 32		# if $s3<32 => $t2=1
 	bne $t2, 0, invalid_value_notice# $t2!=0 ($s3<32) ? InvalidValueMessage|check_output_2
check_output_2:
	slti $t2, $s3, 127		# if $s3<127 => $t2=1
 	bne $t2, 0, add_to_output	# $t2!=0 ($s3<126) ? add_to_output|InvalidValueMessage
invalid_value_notice:
	li $v0, 4			
	la $a0, InvalidValueMessage	
	syscall	 
	j get_string   	 	
add_to_output:				# add ki tu da duoc giai ma vao output
	addi $t3, $t3, 1		# j++
	add $t4, $s2, $t3 		# $t4 = address(output[j])
	sb $s3, 0($t4)			# output[j]=$s3
	add $s3, $zero, $zero		# set lai sum = 0
	j continue
end:

print_output: 				# in ra chuoi ki tu duoc giai ma
 		li $v0, 4			
		la $a0, output  	
		syscall 
endmain:

# some test example:  
# 010010000110000101101001001000000101010001101000011000010110111001101000		#Hai Thanh
# 0111011001100001									#va
# 00100000 										#space
# 0100110001101001011011100110100000100000010000110110100001101001			#Linh Chi
# 01100011011010000110000101101111001000000111010001101000011000010111100100100001	#chao thay!
# 0100100001100001011010010010000001010100011010000110000101101110011010000010000001110110011000010010000001001100011010010110111001101000001000000100001101101000011010010010000001100011011010000110000101101111001000000111010001101000011000010111100100100001
# 00101000010111100010000000110011001000000101111000101001				#(^ 3 ^)
