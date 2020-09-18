.data
Message: .asciiz "Nhap lai diem: "
Diem: .asciiz "Nhap diem: "
Message1: .asciiz "Ten cua nhung sinh vien not  pass toan: \n "
Name: .space 20000
array: .space 20000
Sohocsinh: .asciiz "Nhap so hoc sinh: " 

.text
#@Input :  $t0 : L?u so hoc sinh( Nhap tu ban phim)
#Stack sp : Dung de luu diem va ten cua sinh vien. sp[2i] luu diem , sp[2i+1] luu ten sinh vien
#$t2: Bien chay (i=0)
#$a0 luu dia chi cua  Name ( dau vao khi nhap ten sinh vien)
#@Input_mark: Ham nhap diem cua tung sinh vien
#@Input_Name: Ham nhap ten sinh vien
#@Loop1, Loop2: Kiem tra diem cua sinh vien (lon hon hoac bang 0, nho hon hoac bang 10)
#@Check_Input: Kiem tra xem nhap du so luong sinh vien hay chua.
#@check_notpass: Kiem tra xem sinh vien nao khong qua mon=> In ket qua ten cua nhung sinh vien khong qua mon ra man hinh
#==================================================================================
Main:
	
	li $v0,51 
	la $a0,Sohocsinh  	#$a0 luu giá tri so hoc sinh
	syscall
	
	beq		$a1, -1,Main		# $a1 status value (if input is invalid => Re-input)
	beq		$a1, -3,Main		# $a1 status value (if input is invalid => Re-input)
	beq		$a1, -2, End	
	#Kiem tra xem so hoc sinh lon hon 0
	slt $s4,$a0,$0
	bne $s4,$zero,Main
	add $t0,$a0,$zero # $t0 luu giá tri so hoc sinh (n)
		#tao mang luu diem và tên cho hoc sinh
	sll $t1,$t0,3 #t1=8*n
	
	sub  $sp,$sp,$t1# tao bo nho cho  Sp[2n] 
	 
# Hàm nhap diem va ten
	addi $t2,$zero,0 # t2=i=0
la $s0,Name		#Load dia chi cua Name vao s0
Input_Mark: 
	sll $t3,$t2,3 		#t2=t3*8=8i
	add $a2,$sp,$t3		#a2 tro toi sp[2i]
	# Nhap diem
	li $v0, 51
	la $a0, Diem
	syscall 
	beq		$a1, -1,Input_Mark	# $a1 status value (if input is invalid => Re-input)
	beq		$a1, -3,Input_Mark	# $a1 status value (if input is invalid => Re-input)
	beq		$a1, -2, End
	sw $a0,0($a2)	#Luu diem vao sp[2i]
	
# Xet dieu kien diem nam trong khoang 0-10	
	addi $s5,$zero,10
Loop1:   lw $s6,0($a2)		#lay gia tri diem vua nhap luu vao s6
	slt $s4,$s6,$0		#so sang voi 0
	bne $s4,$zero,Loop2	#Neu nho hon 0 thi den Loop2
	
	slt $s4,$s5,$s6		#So sanh voi 10
	bne $s4,$zero,Loop2	#Neu lon hon 10 thi den Loop2
	
j Input_Name
nop

Loop2:
	# Neu Nhap sai diem thi nhap lai
	li $v0, 51
	la $a0, Message
	syscall
	#Kiem tra xem nhap so hay chu, neu la string thi nhap lai
	beq		$a1, -1,Loop2	# $a1 status value (if input is invalid => Re-input)
	beq		$a1, -3,Loop2	# $a1 status value (if input is invalid => Re-input)
	beq		$a1, -2, End
	sw $a0,0($a2)
j Loop1
nop

Input_Name:
#Nhap ten sinh vien 
	addi $t3,$t3,4 # t3=8i+4
	add $a2,$sp,$t3		#a2 tro toi sp[2i+1]
	move    $a0,$s0             # place to store string [NEW] 
    	li      $a1,16
    	li      $v0,8
    	    syscall
	sw      $a0,0($a2)	#Luu ten vua nhap vao sp[2i+1]
	addi    $s0,$s0,20  	#chuoi tro den vi tri Name[20i]

j Check_Input
nop

Check_Input: 
	addi $t2,$t2,1		#i=i+1
	beq $t2,$t0,End_Input # neu i=n ket thuc viec nhap diem va ten
j Input_Mark		# chua nhap du, nhap tiep
nop
#Ket thuc viec nhap
End_Input:
	addi $t2,$zero,0 # t2=i=0
	addi $t5,$zero,4	# t5=4 ( luu diem de so sanh)
	
	li $v0, 4
	la $a0, Message1
	   syscall

check_notpass:
	sll $t3,$t2,3 # t3= 8*i
	add $t4,$sp,$t3 # t4=sp[2i]	
	lw $s0,0($t4) # s0= sp 2i]
	
	slt $s3,$t5,$s0	#So sanh diem voi 5, neu nho hon thi in ten
	bne $s3,$zero,Check
	addi $t3,$t3,4		#t3=8i+4
	add $t4,$sp,$t3 	#t4 tro den dia chi cua sp[2i+1]
	#In ten sinh vien khong pass mon toan
	lw $s2,0($t4)
	li $v0, 4
	la $a0, 0($s2)
	    syscall  
Check:
	addi $t2,$t2,1
	beq $t2,$t0,End
j check_notpass
nop

#Thoat chuong trinh
End:
li $v0, 10
	syscall







