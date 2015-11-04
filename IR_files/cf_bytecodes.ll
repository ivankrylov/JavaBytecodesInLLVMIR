target triple = "x86_64-apple-macosx10.10"

@TEE_PTR = external global void(void ()*,void ()*)**

declare void @external_throw_ArrayIndexOutOfBoundsException_entry()


attributes #0 = { alwaysinline alignstack=4 }

define void @store_regs() #0 naked  nounwind{
  ;%rsp_val =call i64* asm sideeffect "movq %rsp, $0", "=r" () nounwind
  call void asm sideeffect "mov    %rsp,-0x28 (%rsp)", "" () nounwind
  call void asm sideeffect "sub    0x80,%rsp", "" () nounwind
  call void asm sideeffect "mov    %rax,0x78(%rsp)", "" () nounwind
  call void asm sideeffect "mov    %rcx,0x70(%rsp)", "" () nounwind
  call void asm sideeffect "mov    %rdx,0x68(%rsp)", "" () nounwind
  call void asm sideeffect "mov    %rbx,0x60(%rsp)", "" () nounwind
  call void asm sideeffect "mov    %rbp,0x50(%rsp)", "" () nounwind
  call void asm sideeffect "mov    %rsi,0x48(%rsp)", "" () nounwind
  call void asm sideeffect "mov    %rdi,0x40(%rsp)", "" () nounwind
  call void asm sideeffect "mov    %r8,0x38(%rsp)", "" () nounwind
  call void asm sideeffect "mov    %r9,0x30(%rsp)", "" () nounwind
  call void asm sideeffect "mov    %r10,0x28(%rsp)", "" () nounwind
  call void asm sideeffect "mov    %r11,0x20(%rsp)", "" () nounwind
  call void asm sideeffect "mov    %r12,0x18(%rsp)", "" () nounwind
  call void asm sideeffect "mov    %r13,0x10(%rsp)", "" () nounwind
  call void asm sideeffect "mov    %r14,0x8(%rsp)", "" () nounwind
  call void asm sideeffect "mov    %r15,(%rsp)", "" () nounwind
  ret void
}


define void @iaload_llvm() alwaysinline naked {
  %index_val =call i32 asm sideeffect "mov (%rsp), $0", "=r" () nounwind
  call void asm sideeffect "add    8,%rsp", "" () nounwind
  %array_ptr_asInt =call i64 asm sideeffect "pop $0", "=r" () nounwind
  %array_ptr = inttoptr i64 %array_ptr_asInt to i32*
  %array_len_ptr = getelementptr i32, i32* %array_ptr, i32 3
  %array_len = load i32, i32* %array_len_ptr
  call void asm sideeffect "mov $0, %ebx", "r"(i32 %index_val) nounwind

  %cond = icmp uge i32 %index_val, %array_len
  br i1 %cond, label %throwex, label %normal

normal:
  %index_sqew = add i32 %index_val, 3 
  %result_ptr = getelementptr i32, i32* %array_ptr, i32 %index_sqew
  call void asm sideeffect "mov ($0), %eax", "r"(i32* %result_ptr) nounwind
  br label %return

 throwex:
  tail call void @external_throw_ArrayIndexOutOfBoundsException_entry() nounwind
  br label %return

 return:
  
  call void asm sideeffect "add 0xDEADBEAF, %rsp", "" () nounwind
  call void asm sideeffect "add 0xDEADBEAF, %rsp", "" () nounwind
  call void asm sideeffect "add 0xDEADBEAF, %rsp", "" () nounwind
  call void asm sideeffect "add 0xDEADBEAF, %rsp", "" () nounwind
  call void asm sideeffect "add 0xDEADBEAF, %rsp", "" () nounwind

  ret void
}
define void @iaload_llvm_end() {
  ret void
}

;define cc 17 void @athrow_llvm()  alwaysinline naked  {
;  %exceptionObj = call void(void ()*,void ())* asm sideeffect "movq %rax, $0", "=r" () nounwind
;  %TEE = load void(void ()*,void ())**, void(void ()*,void ())*** @TEE_PTR
;  %JUMP_TO = load void(void ()*,void ())*, void(void ()*,void ())** %TEE
;  tail call void @store_regs() nounwind
;
;  tail call cc 17 void %JUMP_TO(%exceptionObj,%exceptionObj) noinline  nounwind
;  tail call void asm sideeffect "add 0xDEADBEAF, %rsp", "" () nounwind  
;  ret void
;}



define void @athrow_llvm_end() {
  ret void
}

