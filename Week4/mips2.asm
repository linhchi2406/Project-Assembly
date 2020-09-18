#Laboratory Exercise 4, Home Assignment 2
.text
li $s0, 0x0563 #load test value for these function
xor $t2,$s0,$s0


andi $t1, $s0, 0x0400 #Extract bit 10 of $s0