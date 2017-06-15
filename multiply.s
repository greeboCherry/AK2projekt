.file "multiply.s"
base = 10
.data
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
	
	#move number B address
	movl 12(%ebp), %esi
	
	movl $0, %ebx
	movl $0, %ecx
mulloop:
	#multiply two digits
	movl (%edi,%ebx,4), %eax
	mull (%esi,%ecx,4)
	
		push %edi
	movl 16(%ebp), %edi
	#move digits by adding
	addl %eax, (%edi,%ebx,4)
	inc %ebx
	#add carry
	adcl %edx, (%edi,%ebx,4)
		pop %edi


	movl 20(%ebp), %eax
	cmp %eax, %ebx
	jl mulloop

	inc %ecx
	movl %ecx, %ebx
	movl 24(%ebp), %eax
	cmp %eax, %ebx
	jl mulloop

	pop %ebx
	pop %esi
	pop %edi
	movl %ebp, %esp
	pop %ebp
ret
