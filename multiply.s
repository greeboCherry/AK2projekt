.file "multiply.s"
base = 10
.align 32
.data
.bss
	.lcomm length, 100000
	.lcomm lengthA, 100000
	.lcomm lengthB, 100000
	.lcomm carry, 100
.text
.globl multiply
.type multiply, @function
multiply:
	#preparing stack frame
	push %ebp
	movl %esp, %ebp

	#preserving register (ABI)
	push %edi
	push %esi
	push %ebx

	#move number A address
	movl 8(%ebp), %edi
	
	#move number A length
	movl 20(%ebp), %eax
	movl %eax, lengthA
	
	#move number B address
	movl 12(%ebp), %esi

	#move number B length
	movl 24(%ebp), %eax
	movl %eax, lengthB

	#calculate result length
	movl 20(%ebp), %eax
	movl 24(%ebp), %edx
	addl %edx, %eax
	movl %eax, length

	movl $0, %eax
	movl %eax, carry
	movl $0, %ebx
	movl $0, %ecx
mulloop:
	#multiply two digits
	movl (%edi,%ebx,4), %eax
	mull (%esi,%ecx,4)
	addl carry, %eax

		push %edi
		push %esi

	movl 16(%ebp), %edi

	movl %ebx, %esi
	addl %ecx, %esi

	addl (%edi,%esi,4), %eax
		
		push %ecx
		movl $base, %ecx
		divl %ecx
		pop %ecx

	#add remainder
	movl %edx, (%edi,%esi,4)
	#save quotient	
	movl %eax, carry

		pop %esi
		pop %edi

	inc %ebx
	movl lengthA, %eax
cmp %eax, %ebx
jl mulloop

		push %edi
		push %esi
	
		movl 16(%ebp), %edi
		
		movl %ebx, %esi
		addl %ecx, %esi

		movl carry, %eax
		addl %eax, (%edi,%esi,4)
		
		pop %esi
		pop %edi

	inc %ecx
	movl $0, %eax
	movl %eax, carry

	movl $0, %ebx
	movl 24(%ebp), %eax
cmp %eax, %ecx
jl mulloop
	



	mov $0, %ecx
	movl $base, %ebx
	movl 20(%ebp), %eax
	movl 24(%ebp), %edx
	addl %edx, %eax
	movl %eax, %ecx
	dec %ecx
	movl 16(%ebp), %edi

#tabrepair:
#	xor %edx, %edx
#	movl (%edi,%ecx,4), %eax
#	div %ebx
#	movl %edx, (%edi,%ecx,4)
#	dec %ecx
#	addl %eax, (%edi,%ecx,4)
#cmp $0, %ecx
#jnl tabrepair
	


	pop %ebx
	pop %esi
	pop %edi
	movl %ebp, %esp
	pop %ebp
ret
