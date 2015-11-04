	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 10
	.globl	_store_regs
	.align	4, 0x90
_store_regs:                            ## @store_regs
## BB#0:
	## InlineAsm Start
	movq	%rsp, -40(%rsp)
	## InlineAsm End
	## InlineAsm Start
	subq	128, %rsp
	## InlineAsm End
	## InlineAsm Start
	movq	%rax, 120(%rsp)
	## InlineAsm End
	## InlineAsm Start
	movq	%rcx, 112(%rsp)
	## InlineAsm End
	## InlineAsm Start
	movq	%rdx, 104(%rsp)
	## InlineAsm End
	## InlineAsm Start
	movq	%rbx, 96(%rsp)
	## InlineAsm End
	## InlineAsm Start
	movq	%rbp, 80(%rsp)
	## InlineAsm End
	## InlineAsm Start
	movq	%rsi, 72(%rsp)
	## InlineAsm End
	## InlineAsm Start
	movq	%rdi, 64(%rsp)
	## InlineAsm End
	## InlineAsm Start
	movq	%r8, 56(%rsp)
	## InlineAsm End
	## InlineAsm Start
	movq	%r9, 48(%rsp)
	## InlineAsm End
	## InlineAsm Start
	movq	%r10, 40(%rsp)
	## InlineAsm End
	## InlineAsm Start
	movq	%r11, 32(%rsp)
	## InlineAsm End
	## InlineAsm Start
	movq	%r12, 24(%rsp)
	## InlineAsm End
	## InlineAsm Start
	movq	%r13, 16(%rsp)
	## InlineAsm End
	## InlineAsm Start
	movq	%r14, 8(%rsp)
	## InlineAsm End
	## InlineAsm Start
	movq	%r15, (%rsp)
	## InlineAsm End
	retq

	.globl	_iaload_llvm
	.align	4, 0x90
_iaload_llvm:                           ## @iaload_llvm
	.cfi_startproc
## BB#0:
	## InlineAsm Start
	movl	(%rsp), %eax
	## InlineAsm End
	## InlineAsm Start
	addq	8, %rsp
	## InlineAsm End
	## InlineAsm Start
	popq	%rcx
	## InlineAsm End
	cmpl	12(%rcx), %eax
	## InlineAsm Start
	movl	%eax, %ebx
	## InlineAsm End
	jb	LBB1_1
## BB#2:                                ## %throwex
	callq	_external_throw_ArrayIndexOutOfBoundsException_entry
	## InlineAsm Start
	addq	3735928495, %rsp
	## InlineAsm End
	retq
LBB1_1:                                 ## %normal
	addl	$3, %eax
	cltq
	leaq	(%rcx,%rax,4), %rax
	## InlineAsm Start
	movl	(%rax), %eax
	## InlineAsm End
	## InlineAsm Start
	addq	3735928495, %rsp
	## InlineAsm End
	retq
	.cfi_endproc

	.globl	_athrow_llvm_end
	.align	4, 0x90
_athrow_llvm_end:                       ## @athrow_llvm_end
	.cfi_startproc
## BB#0:
	retq
	.cfi_endproc


.subsections_via_symbols
