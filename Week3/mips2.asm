#Laboratory 3, Home Assigment 2
#i<=n
.data 
A: .word -1,2,5,-13
.text
addi $s0, $zero, 0 # max = 0
addi $s1, $zero, 0 # i = 0
la $s2,A
addi $s3,$zero,4 # n=4
addi $s4, $zero,1  # step =1
loop: slt $t2, $s1, $s3 # $t2 = i < n ? 1 : 0
beq $t2, $zero, endloop
add $t1, $s1, $s1 # $t1 = 2 * $s1
add $t1, $t1, $t1 # $t1 = 4 * $s1
add $t1, $t1, $s2 # $t1 store the address of A[i]
lw $t0, 0($t1) # load value of A[i] in $t0
bltz $t0,else   # t0 <0
else: sub $t0,$zero,$t0  # abs(t0)
slt $s5,$s0,$t0    
beq $s5,$zero, andd        
add $s0,$t0,$zero
andd:
add $s1, $s1, $s4 # i = i + step
j loop
endloop:

