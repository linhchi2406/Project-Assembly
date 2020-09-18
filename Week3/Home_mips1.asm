#Laboratory Exercise 3, Home Assignment 1
start:
# m+n<i+j
addi $s2, $zero, 2 #j
addi $s1,$zero,0 #i
add $s4,$s1, $s2 #i+j
addi $s5, $zero,0 #m
addi $s6, $zero, 0 #n
add $s7, $s5,$s6 # m+n
sub $s0,$s7,$s4
slt $t0,$s0,$zero
beq $t0,$zero,else 
addi $t1,$t1,1 # then part: x=x+1
addi $t3,$zero,1 # z=1
j endif # skip “else” part
else: addi $t2,$t2,-1 # begin else part: y=y-1
add $t3,$t3,$t3 # z=2*z
endif:
