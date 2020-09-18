.data
 String: .space 21
Message: .asciiz "\n Xau sau khi dao nguoc : \n"
.text
add $t1,$zero,6 # 20 kí t?
add $s0,$zero,$zero # $s0=i=0
la $a1,String
Main:
li $v0, 12 #Input character
syscall
beq $v0,10,Print_String  # D?ng khi nh?p Enter
add $t2,$a1,$s0 #t2= a[i]
sb $v0,0($t2) #a1[i]= v0=char
addi $s0,$s0,1 # i=i+1
slt $t0,$s0,$t1 #So sánh kí t? ?ang nh?p v?i 20
beq $t0,$zero, Print_String # N?u nh?p h?n 20 kí t? thì d?ng nh?p
j Main
Print_String : 
li $v0, 4 
la $a0,String #print string
syscall

Print:
li $v0, 4 
la $a0,Message #print Message
syscall
strcpy: 
addi $s0,$s0,-1
add $t2,$s0,$a1 # t2= String[i]
lb $t3,0($t2)  # t3=t2
li $v0, 11
la $a0,0($t3) #print string ??o ng??c
syscall
beq $s0,0,End # i=0 thì d?ng
nop
addi $s1,$s1,1
j strcpy
nop
End: 





