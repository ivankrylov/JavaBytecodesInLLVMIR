	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 10
	.globl	_addl_read_2_params_old
	.align	4, 0x90
_addl_read_2_params_old:                ## @addl_read_2_params_old
	.cfi_startproc
## BB#0:
	leaq	(%rdi,%rsi), %rax
	retq
	.cfi_endproc

	.globl	"_addl_read_1-2_param"
"_addl_read_1-2_param":                 ## @addl_read_1-2_param
## BB#0:
	pushq	%rax
	## InlineAsm Start
	movq	%rax, %rax
	## InlineAsm End
	callq	*%rax

	.globl	"_addl_read_1-3_param"
"_addl_read_1-3_param":                 ## @addl_read_1-3_param
## BB#0:
	pushq	%rax
	callq	*%rdi

	.globl	_my_mul
	.align	4, 0x90
_my_mul:                                ## @my_mul
	.cfi_startproc
## BB#0:
	movq	(%rdi), %rax
	imulq	8(%rdi), %rax
	movq	%rax, (%rsi)
	retq
	.cfi_endproc

	.globl	_addl_mull_param
_addl_mull_param:                       ## @addl_mull_param
## BB#0:
	jmp	LBB4_1
LBB4_4:                                 ## %if.ladd
                                        ##   in Loop: Header=BB4_1 Depth=1
	## InlineAsm Start
	incq	%r13
	## InlineAsm End
LBB4_1:                                 ## %add_arg_2
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB4_3 Depth 2
	## InlineAsm Start
	movq	%rax, %rax
	## InlineAsm End
	## InlineAsm Start
	movq	%rsp, %rcx
	## InlineAsm End
	addq	(%rcx), %rax
	## InlineAsm Start
	addq	16, %rsp
	## InlineAsm End
	## InlineAsm Start
	movq	%rax, %rax
	## InlineAsm End
	jmp	LBB4_3
LBB4_2:                                 ## %mul_arg_2
                                        ##   in Loop: Header=BB4_3 Depth=2
	## InlineAsm Start
	incq	%r13
	## InlineAsm End
	## InlineAsm Start
	movq	%rax, %rax
	## InlineAsm End
	## InlineAsm Start
	movq	%rsp, %rcx
	## InlineAsm End
	imulq	(%rcx), %rax
	## InlineAsm Start
	addq	16, %rsp
	## InlineAsm End
	## InlineAsm Start
	movq	%rax, %rax
	## InlineAsm End
LBB4_3:                                 ## %save_and_dispatch
                                        ##   Parent Loop BB4_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	## InlineAsm Start
	movzbl	1(%r13), %eax
	## InlineAsm End
	cmpl	$97, %eax
	je	LBB4_4
## BB#5:                                ## %if.not_ladd
                                        ##   in Loop: Header=BB4_3 Depth=2
	cmpl	$105, %eax
	je	LBB4_2
## BB#6:                                ## %if.not_lmul
	retq

	.globl	_addl_llvm
	.align	4, 0x90
_addl_llvm:                             ## @addl_llvm
	.cfi_startproc
## BB#0:
	addq	(%rsp), %rax
	## InlineAsm Start
	addq	$16, %rsp
	## InlineAsm End
	## InlineAsm Start
	addq	3735928559, %rax
	## InlineAsm End
	retq
	.cfi_endproc

	.globl	_addl_llvm_end
	.align	4, 0x90
_addl_llvm_end:                         ## @addl_llvm_end
	.cfi_startproc
## BB#0:
	retq
	.cfi_endproc

	.globl	_arraylength_llvm
	.align	4, 0x90
_arraylength_llvm:                      ## @arraylength_llvm
	.cfi_startproc
## BB#0:
	movl	12(%rax), %eax
	## InlineAsm Start
	addq	3735928559, %rax
	## InlineAsm End
	retq
	.cfi_endproc

	.globl	_arraylength_llvm_end
	.align	4, 0x90
_arraylength_llvm_end:                  ## @arraylength_llvm_end
	.cfi_startproc
## BB#0:
	retq
	.cfi_endproc

	.globl	_get_fn_addr
	.align	4, 0x90
_get_fn_addr:                           ## @get_fn_addr
	.cfi_startproc
## BB#0:
	movq	_EX_TH@GOTPCREL(%rip), %rax
	retq
	.cfi_endproc

	.globl	_iaload_llvm
	.align	4, 0x90
_iaload_llvm:                           ## @iaload_llvm
	.cfi_startproc
## BB#0:
	movl	%eax, %ebx
	## InlineAsm Start
	popq	%rax
	## InlineAsm End
	cmpl	12(%rax), %ebx
	jb	LBB10_1
## BB#2:                                ## %throwex
	callq	_get_fn_addr
	## InlineAsm Start
	movl	%ebx, %eax
	movl	%ebx, %ebx
	jmpq	*%rax
	## InlineAsm End
	movl	%ebx, %eax
	jmp	LBB10_3
LBB10_1:                                ## %normal
	leal	4(%rbx), %ecx
	movslq	%ecx, %rcx
	movl	(%rax,%rcx,4), %eax
LBB10_3:                                ## %return
	## InlineAsm Start
	addq	3735928559, %rax
	## InlineAsm End
	## InlineAsm Start
	addq	3735928559, %rax
	## InlineAsm End
	## InlineAsm Start
	addq	3735928559, %rax
	## InlineAsm End
	## InlineAsm Start
	addq	3735928559, %rax
	## InlineAsm End
	## InlineAsm Start
	addq	3735928559, %rax
	## InlineAsm End
	## InlineAsm Start
	addq	3735928559, %rax
	## InlineAsm End
	movl	%ebx, %edx
	retq
	.cfi_endproc

	.globl	_iaload_llvm_end
	.align	4, 0x90
_iaload_llvm_end:                       ## @iaload_llvm_end
	.cfi_startproc
## BB#0:
	retq
	.cfi_endproc

.zerofill __DATA,__bss,_msg,8,3         ## @msg

.subsections_via_symbols
