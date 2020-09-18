.data
Message1: .asciiz "The largest :  "
Message2: .asciiz ",   "
Message3: .asciiz " \n The smallest :   "
Message4: .asciiz " ,   "

.text
main: # gan cac gia tri cho cac thanh ghi
li $s0,1
li $s1,8
li $s2,4
li $s3,9
li $s4,5
li $s5,6
li $s6,3
li $s7,10
addi $t5,$zero,2# có n=8 ph?n t?
addi $t6,$zero,0 # i=0;
# Gán giá tr? các thanh ghi vào stack Sp
begin:
addi $sp,$sp,-28
sw $s0,0($sp) # L?u tr? s0 vào stack ??u
sw $s1,4($sp)
sw $s2,8($sp)
sw $s3,12($sp)
sw $s4,16($sp)
sw $s5,20($sp)
sw $s6,24($sp)
sw $s7,28($sp)
# L?u tr? v? tri vào t2 và t4
# t1: giá tr? max, t3: giá tr? min
add $t1,$zero,$s0 # t1=s0
addi $t2,$zero,0
add $t3,$zero,$s0 #t2=s0
addi $t4,$zero,0
jal Max_Min
print:
li $v0,4
la $a0 ,Message1
syscall 
li $v0, 1
la $a0, 0($t1)
syscall
li $v0,4
la $a0 ,Message2
syscall 
li $v0, 1
la $a0, 0($t2)
syscall
li $v0,4
la $a0 ,Message3
syscall 
li $v0, 1
la $a0, 0($t3)
syscall
li $v0,4
la $a0 ,Message4
syscall 
li $v0, 1
la $a0, 0($t4)
syscall
# Thoát kh?i ch??ng trình
quit: li $v0, 10 #terminate
syscall
Max_Min:
add $s0,$t6,$t6 # s0=i+i
add $s0,$s0,$s0 # s0=4i
add $s1,$s0,$sp # s1= sp[i]
lw $s2,0($s1) # l?u giá tr? c?a s1 sang s2
slt $s3,$t1,$s2 # N?u $s2>$t1 ( $t1 ch?a ??t giá tr? max) 
bne $s3,$zero,Max # chuy?n ??n Max
Min_1:
slt $s4,$s2,$t3 # N?u $s2>$s2 ( $t3 ?ang ??t giá tr? min)
bne $s4,$zero,Min # CHuy?n ??n min
j test
nop 
Max:
add $t2,$zero,$t6 # v? trí giá tr? max là i
add $t1,$zero,$s2 # gán max b?ng s2
j Min_1
Min: 
add $t4,$zero,$t6
add $t3,$zero,$s2  # gán min b?ng s2 
j test
nop
test:
addi $t6,$t6,1 # i=i+1
addi $s6,$zero,7
slt $s5,$s6,$t6 #set $t5 to 1 if i<n
bne $s5,$zero,done #repeat if i>n
j Max_Min
nop
done: 
#addi $sp,$fp,0 #restore stack pointer
#lw $fp,-4($sp) #restore frame pointer
jr $ra # v? ch??ng trình chính
nop