.data
Message01: .asciiz "The sum of " 
Message02: .asciiz " and "
Message03: .asciiz " is "
.text
addi $s0, $zero, 3
addi $s1, $zero, 4
add  $t1, $s0, $s1
li $v0, 4
la $a0, Message01
syscall
li $v0, 1
la $a0, 0($s0)
syscall
li $v0, 4
la $a0, Message02
syscall
li $v0, 1
la $a0, 0($s1)
syscall
li $v0, 4
la $a0, Message03
syscall
li $v0, 1
la $a0, 0($t1)
syscall