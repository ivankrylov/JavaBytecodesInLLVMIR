
Author: Ivan Krylov

This project is a prototype for generating Java Bytecode interpreter templates using LLVM IR.

In the diffs directory there os a patch for openjdk9_b80/hotspot/ to execute newly generated templates instead if existing ones (written in asm). There is also a patch for LLVM 3.4.x to support a new calling convention for template-to-native transitions.
The IR_files directory contains a few simple java templates.

This work was stopped because of the lack of resources and uncertainty that writing and maintaining ll files is feasible in a arch-agnostic manner. LLVM IR misses some stack manipulation primitives that allow to mix java operands- and native stacks. As a result we would need to separate those two stacks and in that case we depart from one of the original ideas of the the template interpreter. We would also loose the opportunity to incrementally replace x86 template with LLVM IR derived ones.


