target triple = "x86_64-apple-macosx10.10"

; static address*   Interpreter::dispatch_table(4)
;  0x000000010a59ba30: movzbl 0x1(%r13),%ebx
;  0x000000010a59ba35: inc    %r13
;  0x000000010a59ba38: movabs $0x10a0f5e00,%r10
;  0x000000010a59ba42: jmpq   *(%r10,%rbx,8)

@EX_TH = external global void()*

; External declaration of the hotspot_dispatch_table function
declare i64* @hotspot_dispatch_table(i32 ) nounwind

; CHECK: @my_add
;define void @my_add(i64* %v1) {
;  %l = load i64, i64* %v1
;  %a2 = getelementptr i64, i64* %v1, i64 1
;  %l6 = load i64, i64* %a2
;  %l10 = add i64 %l, %l6
;  ret void
;}

; CHECK: @my_add
;define i64 @my_add(i64* %v1) {
;  %l = load i64, i64* %v1
;  %a2 = getelementptr i64, i64* %v1, i64 1
;  %l6 = load i64, i64* %a2
;  %l10 = add i64 %l, %l6
;  ret i64 %l10
;}

;CHECK: @addl_read_2_params_old
define i64 @addl_read_2_params_old(i64 %p1, i64 %p2) {
  %l_result = add i64 %p1, %p2
  ret i64 %l_result
}

;CHECK: @addl_read_1_params
;define i64 @addl_read_1-1_params(i64 %p1, i64 %p2) "no-frame-pointer-elim-non-leaf" nounwind optsize ssp {
;  %l_result = add i64 %p1, %p2
;  ret i64 %l_result
;}


;CHECK: @addl_read_1-2_param
define void @addl_read_1-2_param() "no-frame-pointer-elim" nounwind optsize ssp {
; No stack frame, please.

  %l_param1 = call i64 asm  "movq %rax, $0", "=r" () nounwind
  %exp_stack =call i64* asm "movq %rsp, $0", "=r" () nounwind
  %l_param2 = load i64, i64* %exp_stack

  ;%l_result = add i64 %l_param1, %l_param2
  ;call void asm "movq $0, %rax", "r"(i64 %l_param1) nounwind


  ;%disp_table_addr = call i64* @hotspot_dispatch_table(i32 4)
  ;%next_bytecode = call i32 asm sideeffect "movzbl 0x1(%r13), $0\0A\09inc %r13", "=r"() nounwind
  
  ;%next_bytecode_64 = zext i32 %next_bytecode to i64
  ;%next_bytecode_x8 = mul i64 %next_bytecode_64, 8
  ;%disp_table_i64 = ptrtoint i64* %disp_table_addr to i64

  ;%disp_table_i64 = add i64 %l_param2, 0

  ;%jump_addr = add i64 %next_bytecode_x8, %disp_table_i64
  ;%ptr = inttoptr i64 %jump_addr to void ()*
  ;call void asm sideeffect "add 0x10, %rsp", "" () nounwind
  ;tail call void %ptr () nounwind

  %ptr = inttoptr i64 %l_param1 to void ()*
  tail call void %ptr () nounwind

  unreachable  
  ret void
}


;CHECK: @addl_read_1-3_param
define void @addl_read_1-3_param(void ()* %l_param1) "no-frame-pointer-elim" nounwind optsize ssp {
; No stack frame, please.

  ;%l_param1 = call void ()* asm  "movq %rax, $0", "=r,~{rax}" () nounwind
  tail call void %l_param1 () nounwind

  unreachable  
  ret void
}



;CHECK: @addl_read_2_params_old
;define void @addl_read_2_params_old() {
;  %exp_stack =call i64* asm sideeffect "movq %rsp, $0\0A\09addq 16, %rsp", "=r,~{rsp},~{dirflag},~{fpsr},~{flags}" () nounwind
;  %l_param1 = load i64, i64* %exp_stack
;  %l_param2_addr = getelementptr i64 , i64* %exp_stack, i64 1
;  %l_param2 = load i64, i64* %l_param2_addr
;
;  %l_result = add i64 %l_param1, %l_param2
;  call void asm sideeffect "movq $0, %rax", "r,~{rax},~{dirflag},~{fpsr},~{flags}"(i64 %l_result) nounwind
;
;
;  %disp_table_addr = call i64* @hotspot_dispatch_table(i32 4)
;  %next_bytecode = call i32 asm sideeffect "movzbl 0x1(%r13), $0\0A\09inc %r13", "=r,~{r13},~{rsp},~{dirflag},~{fpsr},~{flags}"() nounwind
;  
;  %next_bytecode_64 = zext i32 %next_bytecode to i64
;  %next_bytecode_x8 = mul i64 %next_bytecode_64, 8
;  %disp_table_i64 = ptrtoint i64* %disp_table_addr to i64
;  %jump_addr = add i64 %next_bytecode_x8, %disp_table_i64
;  %ptr = inttoptr i64 %jump_addr to void ()*
;  tail call void %ptr ()  
;  ret void
;}


@msg = internal global i8* null                   ; <i8**> [#uses=1]


; CHECK: @my_add
;define void @my_add(i64* %v1, i64* %res,i64* %bytecodes_fns, i8* %bcp) {
;  %l = load i64, i64* %v1
;  %a2 = getelementptr i64, i64* %v1, i64 1
;  %l6 = load i64, i64* %a2
;  %l10 = add i64 %l, %l6
;  store i64 %l10, i64* %res
;  ret void
;}

; CHECK: @my_mul
define void @my_mul(i64* %v1, i64* %res,i64* %bytecodes_fns, i8* %bcp) {
  %l = load i64, i64* %v1
  %a2 = getelementptr i64, i64* %v1, i64 1
  %l6 = load i64, i64* %a2
  %l10 = mul i64 %l, %l6
  store i64 %l10, i64* %res
  ret void
}



; CHECK: @my_add
;define i64 @my_add(i64* %v1) {
;  %l = load i64, i64* %v1
;  %addr = ptrtoint i64* %v1 to i64
;  %l4 = add i64 %addr, 8
;  %l5 = inttoptr i64 %l4 to i64*
;  %l6 = load i64, i64* %l5
;  %l7 = add i64 %addr, 16
;  %l8 = inttoptr i64 %l7 to i64*
;  %l10 = add i64 %l, %l6
;  ret i64 %l10
;}


;CHECK: @addl_mull_param  ; i32 %entry_selector
define void @addl_mull_param() "no-frame-pointer-elim-non-leaf" nounwind optsize ssp {
; No stack frame, please.

  ;%cmp_entry_ladd = icmp eq i32 %entry_selector, 0
  ;br i1 %cmp_entry_ladd, label %add_arg_2, label %mul_arg_2
  br label %add_arg_2

add_arg_2:
  %l_param1_add_arg_2 = call i64 asm sideeffect "movq %rax, $0", "=r" () nounwind
  %exp_stack_add_arg_2 =call i64* asm sideeffect "movq %rsp, $0", "=r" () nounwind
  %l_param2_add_arg_2 = load i64, i64* %exp_stack_add_arg_2
  call void asm sideeffect "add 0x10, %rsp", "" () nounwind
  %l_result_add_arg_2 = add i64 %l_param1_add_arg_2, %l_param2_add_arg_2
  call void asm sideeffect "movq $0, %rax", "r"(i64 %l_result_add_arg_2) nounwind
  br label %save_and_dispatch

add_arg_1_2:
  %exp_stack_add_arg_1_2 =call i64* asm sideeffect "movq %rsp, $0", "=r" () nounwind
  %l_param1_add_arg_1_2 = load i64, i64* %exp_stack_add_arg_1_2
  %exp_stack_2_add_arg_1_2 = getelementptr i64, i64* %exp_stack_add_arg_1_2, i64 1
  %l_param2_add_arg_1_2 = load i64, i64* %exp_stack_2_add_arg_1_2
  call void asm sideeffect "add 0x20, %rsp", "" () nounwind
  %l_result_add_arg_1_2 = add i64 %l_param1_add_arg_1_2, %l_param2_add_arg_1_2
  call void asm sideeffect "movq $0, %rax", "r"(i64 %l_result_add_arg_1_2) nounwind
  br label %save_and_dispatch

sub_arg_2:
  %l_param1_sub_arg_2 = call i64 asm sideeffect "movq %rax, $0", "=r" () nounwind
  %exp_stack_sub_arg_2 =call i64* asm sideeffect "movq %rsp, $0", "=r" () nounwind
  %l_param2_sub_arg_2 = load i64, i64* %exp_stack_sub_arg_2
  call void asm sideeffect "add 0x10, %rsp", "" () nounwind
  %l_result_sub_arg_2 = sub i64 %l_param1_sub_arg_2, %l_param2_sub_arg_2
  call void asm sideeffect "movq $0, %rax", "r"(i64 %l_result_sub_arg_2) nounwind
  br label %save_and_dispatch

sub_arg_1_2:
  %exp_stack_sub_arg_1_2 =call i64* asm sideeffect "movq %rsp, $0", "=r" () nounwind
  %l_param1_sub_arg_1_2 = load i64, i64* %exp_stack_sub_arg_1_2
  %exp_stack_2_sub_arg_1_2 = getelementptr i64, i64* %exp_stack_sub_arg_1_2, i64 1
  %l_param2_sub_arg_1_2 = load i64, i64* %exp_stack_2_sub_arg_1_2
  call void asm sideeffect "add 0x20, %rsp", "" () nounwind
  %l_result_sub_arg_1_2 = sub i64 %l_param1_sub_arg_1_2, %l_param2_sub_arg_1_2
  call void asm sideeffect "movq $0, %rax", "r"(i64 %l_result_sub_arg_1_2) nounwind
  br label %save_and_dispatch

mul_arg_2:
  %l_param1_mul_arg_2 = call i64 asm sideeffect "movq %rax, $0", "=r" () nounwind
  %exp_stack_mul_arg_2 =call i64* asm sideeffect "movq %rsp, $0", "=r" () nounwind
  %l_param2_mul_arg_2 = load i64, i64* %exp_stack_mul_arg_2
  call void asm sideeffect "add 0x10, %rsp", "" () nounwind
  %l_result_mul_arg_2 = mul i64 %l_param1_mul_arg_2, %l_param2_mul_arg_2
  call void asm sideeffect "movq $0, %rax", "r"(i64 %l_result_mul_arg_2) nounwind
  br label %save_and_dispatch

mul_arg_1_2:
  %exp_stack_mul_arg_1_2 =call i64* asm sideeffect "movq %rsp, $0", "=r" () nounwind
  %l_param1_mul_arg_1_2 = load i64, i64* %exp_stack_mul_arg_1_2
  %exp_stack_2_mul_arg_1_2 = getelementptr i64, i64* %exp_stack_mul_arg_1_2, i64 1
  %l_param2_mul_arg_1_2 = load i64, i64* %exp_stack_2_mul_arg_1_2
  call void asm sideeffect "add 0x20, %rsp", "" () nounwind
  %l_result_mul_arg_1_2 = mul i64 %l_param1_mul_arg_1_2, %l_param2_mul_arg_1_2
  call void asm sideeffect "movq $0, %rax", "r"(i64 %l_result_mul_arg_1_2) nounwind
  br label %save_and_dispatch

save_and_dispatch:

  ;%disp_table_addr = call i64* @hotspot_dispatch_table(i32 4)
  ;%next_bytecode = call i32 asm sideeffect "movzbl 0x1(%r13), $0\0A\09inc %r13", "=r"() nounwind
  %next_bytecode = call i32 asm sideeffect "movzbl 0x1(%r13), $0", "=r"() nounwind
  
  ; ladd is 97
  %cmp = icmp eq i32 %next_bytecode, 97
  br i1 %cmp, label %if.ladd, label %if.not_ladd
  unreachable

if.ladd:

  call void asm sideeffect "inc %r13", ""() nounwind
  br label %add_arg_2
  unreachable

if.not_ladd:

  ; lmul is 105
  %cmp_lmul = icmp eq i32 %next_bytecode, 105
  br i1 %cmp_lmul, label %if.lmul, label %if.not_lmul
  unreachable

if.lmul:

  call void asm sideeffect "inc %r13", ""() nounwind
  br label %mul_arg_2
  unreachable

if.not_lmul:
  ret void
}



define cc 17 i64 @addl_llvm(i64 %BCP, i64* %RSP, i64 %RAX) {
  %arg2 = load i64, i64* %RSP
  call void asm sideeffect "addq $$16, %rsp", "~{%rsp}" () nounwind

  %result = add i64 %RAX, %arg2

  call void asm sideeffect "addq 0xDEADBEEF, %rax", "" () nounwind  
  ret i64 %result
}

define void @addl_llvm_end() {
  ret void
}

define cc 17 i32 @arraylength_llvm(i64 %BCP, i64* %RSP, i32* %RAX) {
  %length_ptr = getelementptr i32, i32* %RAX, i32 3
  %length = load i32, i32* %length_ptr
  call void asm sideeffect "addq 0xDEADBEEF, %rax", "" () nounwind  
  ret i32 %length
}


define void @arraylength_llvm_end() {
  ret void
}

@TEE_PTR = external global void(void ()*,void ()*)**

;@external_throw_ArrayIndexOutOfBoundsException_entry = external global void()*

define void()** @get_fn_addr() noinline readonly naked {
  ret void ()** @EX_TH
}


define cc 17 {i32, i32} @iaload_llvm(i32 %EAX, i64 %BCP, i64* %RSP, i64 %ex) alwaysinline naked {
  
  %array_ptr_asInt =call i64 asm sideeffect "pop $0", "=r" () nounwind
  %array_ptr = inttoptr i64 %array_ptr_asInt to i32*
  %array_len_ptr = getelementptr i32, i32* %array_ptr, i32 3
  %array_len = load i32, i32* %array_len_ptr

  %cond = icmp uge i32 %EAX, %array_len
  br i1 %cond, label %throwex, label %normal

normal:
  %index_sqew = add i32 %EAX, 4 
  %result_ptr = getelementptr i32, i32* %array_ptr, i32 %index_sqew
  %result_normal = load i32, i32* %result_ptr
  br label %return

 throwex:
  ;tail call cc 11 void %ex() nounwind
  %fn = call void ()** @get_fn_addr() nounwind noinline
  call void asm sideeffect "movl $0, %eax\0A\09movl $1, %ebx\0A\09jmpq *$2", "r,r,r"(i32 %EAX, i32 %EAX, void ()** %fn) nounwind
  br label %return

 return:
  
  %result = phi i32 [%result_normal, %normal], [%EAX, %throwex]

  %rv1 = insertvalue { i32, i32 } undef, i32 %result, 0
  %rv2 = insertvalue { i32, i32 } %rv1, i32 %EAX, 1

  call void asm sideeffect "addq 0xDEADBEEF, %rax", "" () nounwind  
  call void asm sideeffect "addq 0xDEADBEEF, %rax", "" () nounwind  
  call void asm sideeffect "addq 0xDEADBEEF, %rax", "" () nounwind  
  call void asm sideeffect "addq 0xDEADBEEF, %rax", "" () nounwind  
  call void asm sideeffect "addq 0xDEADBEEF, %rax", "" () nounwind  
  call void asm sideeffect "addq 0xDEADBEEF, %rax", "" () nounwind  

  ret {i32,i32} %rv2
}
define void @iaload_llvm_end() {
  ret void
}


