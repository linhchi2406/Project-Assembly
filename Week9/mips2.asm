.eqv MONITOR_SCREEN 0x10010000
.eqv RED 0x00FF0000
.eqv GREEN 0x0000FF00
.eqv BLUE 0x000000FF
.eqv WHITE 0x00FFFFFF
.eqv YELLOW 0x00FFFF00
.text
li $k0, MONITOR_SCREEN
li $s1,8 # n=8
li $s2,0 #i=0

Hang1: 
li $s3,395
add $s3,$s3,$s2
sll $s3,$s3,2 
add $a0,$k0,$s3
li $t0, RED
sw $t0,0($a0)
addi $s2,$s2,1
slt $t1,$s2,$s1
bne $s2,$s1,Hang1

li $s2,0 #i=0
Hang2: 
li $s3,427
add $s3,$s3,$s2
sll $s3,$s3,2 
add $a0,$k0,$s3
li $t0, RED
sw $t0,0($a0)
addi $s2,$s2,1
slt $t1,$s2,$s1
bne $s2,$s1,Hang2

li $s2,0 #i=0
Hang3: 
li $s3,459
add $s3,$s3,$s2
sll $s3,$s3,2 
add $a0,$k0,$s3
li $t0, RED
sw $t0,0($a0)
addi $s2,$s2,1
slt $t1,$s2,$s1
bne $s2,$s1,Hang3


li $s2,0 #i=0
Hang4: 
li $s3,491
add $s3,$s3,$s2
sll $s3,$s3,2 
add $a0,$k0,$s3
li $t0, RED
sw $t0,0($a0)
addi $s2,$s2,1
slt $t1,$s2,$s1
bne $s2,$s1,Hang4


li $s2,0 #i=0
Hang5: 
li $s3,523
add $s3,$s3,$s2
sll $s3,$s3,2 
add $a0,$k0,$s3
li $t0, RED
sw $t0,0($a0)
addi $s2,$s2,1
slt $t1,$s2,$s1
bne $s2,$s1,Hang5


li $s2,0 #i=0
Hang6: 
li $s3,555
add $s3,$s3,$s2
sll $s3,$s3,2 
add $a0,$k0,$s3
li $t0, RED
sw $t0,0($a0)
addi $s2,$s2,1
slt $t1,$s2,$s1
bne $s2,$s1,Hang6


li $s2,0 #i=0
Hang7: 
li $s3,587
add $s3,$s3,$s2
sll $s3,$s3,2 
add $a0,$k0,$s3
li $t0, RED
sw $t0,0($a0)
addi $s2,$s2,1
slt $t1,$s2,$s1
bne $s2,$s1,Hang7


li $s2,0 #i=0
Hang8: 
li $s3,619
add $s3,$s3,$s2
sll $s3,$s3,2 
add $a0,$k0,$s3
li $t0, RED
sw $t0,0($a0)
addi $s2,$s2,1
slt $t1,$s2,$s1
bne $s2,$s1,Hang8


bne
