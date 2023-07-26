.data
oi: .word 8

.text
#addi t0,zero,zero
#addi t1,zero,zero
addi t0,zero,20
addi t1,zero,10
addi a1,zero,0

loop:
addi t0,t0,2
addi t1,t1,3
addi a1,a1,1
blt t0,t1,multi
bne t0,t1, loop

li a7,10
ecall

multi:
la s2, oi
sw a1,-10(s2)
add s2,a1,zero
add a1,a1,t1
lw a1,-10(s2)

while:
beq s2, zero, exit
addi t0,t0,-2
addi t1,t1,-3
addi s2,s2,-1
j while


exit:
slli a1,a1,2
li a7,10
ecall