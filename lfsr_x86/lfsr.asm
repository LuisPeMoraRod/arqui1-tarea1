	global _start

	section .data
seed:	dq 	82 	;ASCII code for 'R'
iter_max: dq	10

	section .text
_start:
	mov rax, [seed]	;load seed number to eax
	mov rbx, [iter_max]
_rand:
	mov rcx, 0 	;initialize iterator
_rand_loop:
	cmp rcx, rbx
	je _exit ; stop condition
	
	push rax ; save random number in memory
	
	; move bit 8 into r8
	mov r8, rax
	and r8, 0b1 
	
	; move bit 6 into r9
	mov r9, rax
	and r9, 0b100
	shr r9, 2
	
	; move bit 5 into r10
	mov r10, rax
	and r10, 0b1000
	shr r10, 3

	; move bit 4 into r11
	mov r11, rax
	and r11, 0b10000
	shr r11, 4

	; get feedback value
	xor r8, r9
	xor r8, r10
	xor r8, r11

	; update rax number
	shl r8, 7
	shr rax, 1
	xor rax, r8

	inc rcx
	jmp _rand_loop ;loop


_exit:
	;exit program
	mov eax, 60	;syscall: exit
	xor edi, edi	;status: 0
	syscall

