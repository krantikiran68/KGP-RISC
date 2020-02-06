# KGP-RISC

A Reduced Instruction Set Computer (RISC) is a microprocessor architecture that utilizes a small number of simple and generalized instructions rather than complex and specialized ones. 

This microprocessor has been developed in the Verilog hardware description language, simulated on the [Xilinx ISE](https://www.xilinx.com/products/design-tools/ise-design-suite.html) and tested on the Spartan 3 FPGA.

This is a top level overview of the microprocessor.
![Top Module](/Images/top_mod.png)

### Instructions

This RISC processor uses 32-bit instructions. The division of the 32-bit instructions has been inspired by the MIPS architecture.
![Instruction](/Images/instr.png)

### ISA
The instruction set architecture of the processor to mirror the functions of the MIPS microprocessor architecture.
![ISA](/KGP_RISC%20Instruction%20Set%20Architecture%20.pdf)   

#### Contributors
This processor is a joint project by
1. [G Rahul Kranti Kiran](https://github.com/krantikiran68)
1. [Sai Saketh Aluru](https://github.com/SaiSakethAluru)

Refer to [documentation](KGP_RISC_Documentation.pdf) for implementation details. 
