../llvm_build/bin/opt -O1   ./arith_bytecodes.ll  |  ../llvm_build/bin/llc    -filetype=obj -o arith_bytecodes.o && ../llvm_build/bin/llvm-objdump  -disassemble ./arith_bytecodes.o
