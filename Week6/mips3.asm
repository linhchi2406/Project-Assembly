.data
A: .word 7,-2,8,4
.text
main:
la $a0,A # a0 ch?a gtri m?ng A
li $t0,4  #$t0: S? ph?n t? c?a m?ng
add $t6,$zero,$zero # $t6 la temp
addi $t1,$zero,0 # gtri c?a i=0
addi $t2,$zero,0 # gtri cua j=0
addi $t4,$zero,4 # gan t?m giá tr? c?a j+1 = 4 byte;
Sort:
add $t3,$t2,$t2 
add $t3,$t3,$t3 # j=4*j
add $t4,$t3,$t4 # t4= j+1
add $t5,$t3,$a0 # gan t5=A[j]
add $t6,$t4,$a0 # gan t5=A[j+1]
 lw $s1,0($t5)
 lw $s2,0($t6)
slt $s3,$s2,$s1 # neu A[j+1]<A[j}
bne $s3,$zero,swap
j Loop2
nop
swap:
sw $s1,0($t6)
sw $s2,0($t5)
j Loop2
nop
Loop2:
addi $t2,$t2,1 # t?ng giá tr? c?a j lên 1
addi $t4,$zero,4
sub $s4,$t0,$t1 # s4= 5-i
addi $s4,$s4,-1
slt $s5,$t2,$s4 # Neu j< 5-i => tiep tuc
bne $s5,$zero,Sort
j Loop1
nop
Loop1:
addi $t1,$t1,1
addi $t2,$zero,0 # gtri cua j=0
slt $s4,$t1,$t0 #set $s5 to 1 if i<n
bne $s4,$zero,Loop2
j End
nop
End: 

