.global _start

.data
seed:	.word 82 @ASCII code for 'R'
iter_max: .word 10

.text
.equ SYS_EXIT, 1 @system call number for exit

_start:
	ldr r0, =seed
	ldr r0, [r0] @load seed number to r0

_rand:
	mov r1, #0 @initialize iterator
	ldr r2, =iter_max
	ldr r2, [r2] @load iter_max to r2
	
_rand_loop:
	cmp r1, r2
	beq _exit @stop condition

	stmfd sp!, {r0} @load to memory new random number
	
	@move bit 8 into r3
	and r3, r0, #0b1 

	@move bit 6 into r4
	and r4, r0, #0b100 	
	lsr r4, r4, #2

	@move bit 5 into r5
	and r5, r0, #0b1000
	lsr r5, r5, #3

	@move bit 4 into r6
	and r6, r0, #0b10000
	lsr r6, r6, #4

	@get feedback value
	eor r3, r3, r4
	eor r3, r3, r5
	eor r3, r3, r6

	@update r0 number
	lsl r3, r3, #7
	lsr r0, r0, #1
	eor r0, r0, r3
	
	add r1, r1, #1
	b _rand_loop

_exit:
	mov r7, #SYS_EXIT
	mov r0, #0
	swi 0
