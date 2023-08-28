.global _start

.data
seed: .byte 82 #ASCII code for 'R'
base_mem: .word 0x100 #base memory address
iter_max: .word 0xa 

.text
_start:
	lb a0, seed # load seed number to a0
	#lw sp, base_mem # move stack pointer to 0x100 address
rand:
	add a1, zero, zero # initialize iterator
	#lw a2, iter_max
	addi a2, zero, 10
rand_loop:
	beq a1, a2, exit # stop condition 
	
	sw a0, 0(sp) # save random number in memory
	addi sp, sp, 4 # update stack pointer
	
	# move bit 8 into t0
	andi t0, a0, 0b1

	# move bit 6 into t1
	andi t1, a0, 0b100
	li t4, 2
	srl t1, t1, t4
	
	# move bit 5 into t2
	andi t2, a0, 0b1000
	li t4, 3
	srl t2, t2, t4
	
	# move bit 4 into t3
	andi t3, a0, 0b10000
	li t4, 4
	srl t3, t3, t4

	# get feedback value
	xor t0, t0, t1
	xor t0, t0, t2
	xor t0, t0, t3
	
	# update a0 number
	li t1, 7
	sll t0, t0, t1
	li t1, 1
	srl a0, a0, t1
	xor a0, a0, t0
	
	addi a1, a1, 1 
	j rand_loop

exit:
    # Exit program
    li a7, 10
    ecall
