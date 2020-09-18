.data
A: .word  7,-2
.text
main:
la $a0,A # a0 ch?a gtri m?ng A
li $t0,2  #$t0: S? ph?n t? c?a m?ng
add $t6,$zero,$zero # $t6 la temp
addi $t1,$zero,0 # gtri c?a i=1
addi $t4,$zero,4 # gan t?m giá tr? c?a j+1 = 4 byte;
Loop1:
addi $t1,$t1,1 # i=i+1
add $s6,$t1,$t1
add $s6,$s6,$s6 # i=4i 
add $s7,$s6,$a0
lw $a1,0($s7) # a1=A[i]
addi $t2,$t1,-1 # gtri cua j = i-1
slt $s4,$t1,$t0 #set $s5 to 1 if i<n
bne $s4,$zero,Loop2
j End
nop
Sort:
 sw $s1,0($t6)
 addi $t2,$zero,-1 # j=j-1
 sw $a1,0($t6)
j Loop2
nop
Loop2:
addi $t4,$zero,4
add $t3,$t2,$t2 
add $t3,$t3,$t3 # j=4*j
add $t4,$t3,$t4 # t4= j+1
add $t5,$t3,$a0 # gan t5=A[j]
add $t6,$t4,$a0 # gan t5=A[j+1]
 lw $s1,0($t5)
 lw $s2,0($t6)
slt $s5,$t2,$zero # Neu 0>j => tiep tuc
bne $s5,$zero,Jump
slt $s6,$a1,$s1 # Neu a[j]>key => tra ve 0
bne $s5,$zero,Sort

j Loop1
nop
Jump:
sw $a1,0($t6) 
j Loop1
nop
End: 

