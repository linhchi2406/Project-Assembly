#Laboratory Exercise 4, Home Assignment 1
.text
start:
addi $s1,$zero,3
addi $s2,$zero,-2
li $t0,0 #No Overflow is default status
addu $s3,$s1,$s2 # s3 = s1 + s2
xor $t2,$s1,$s2
bltz $t2, Exit
xor $t1,$s3,$s2
bltz $t1,Overflow
j Exit
Overflow : li $t0,1
Exit:



