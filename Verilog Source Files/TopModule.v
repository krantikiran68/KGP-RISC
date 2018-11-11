`timescale 1ns / 1ps
`default_nettype none
/*
Assignment No - 7
Semester - Autumn 2018
Group - 3
Members:
  G Rahul KrantiKiran - 16CS10018
  Sai Saketh Aluru - 16CS30030
*/

// The top module for a 32 bit RISC processor
module TopModule( input wire clk, input wire rst,output wire instruction_bit,output 	wire alu_result_bit,
						output wire jump_offset_bit, output wire pc_bit );//Variables declared as output only for trial means
//	wire [31:0] pc = 32'b0;
	wire [31:0] pc;
	wire [31:0] instruction;
	wire [31:0] alu_result;
	wire[25:0] jump_offset;
	assign instruction_bit = instruction[0];
	assign pc_bit = pc[0];
	assign jump_offset_bit = jump_offset[0];
	assign alu_result_bit = alu_result[0];
	wire [5:0] opcode; // The opcode
	wire [4:0] reg_addr_1, reg_addr_2, shift_amount; // Buses to the register Bank
	wire [10:0] opcode_ext; // The extended opcode
	wire [20:0] immediate_const; // The immediate constant for the addi, subi and compi instructions
	wire [25:0] offset; // The offset for the jump instructions
	InstructionDecoder ID(.instruction(instruction),.opcode(opcode), .reg_addr_1(reg_addr_1),.reg_addr_2(reg_addr_2),.shift_amount(shift_amount),
									.opcode_ext(opcode_ext),.immediate_const(immediate_const),.offset(offset)); // The instruction decoder to break down the instructions into smaller opcodes
	wire [3:0] alu_control; // The control signal to the ALU
	wire Branch, regWrite, MemWrite,MemRead,ALU_src,const_src,reg_data,reg_to_pc,regWrite_select; // The control signal form the control unit
	wire zero_flag, carry_flag, sign_flag, overflow_flag; // The flags from the ALU
	InstructionFetch IF(.pc(pc),.instruction(instruction),.clk(clk),.rst(rst)); // THe instruction fetch module contains the bram instance to read the instructions
	ControlUnit CU (.opcode(opcode),.opcode_ext(opcode_ext),.clk(clk),.rst(rst),.alu_control(alu_control),
					 .Branch(Branch),.regWrite(regWrite),.MemRead(MemRead),.MemWrite(MemWrite),.ALU_src(ALU_src),.regWrite_select(regWrite_select),
					 .const_src(const_src),.reg_data(reg_data),.reg_to_pc(reg_to_pc));
	// The control unit module
	
	DataPath DP (.clk(clk),.rst(rst),.regWriteEnable(regWrite),.regAddr_1(reg_addr_1),.regAddr_2(reg_addr_2),.shift_amount(shift_amount), 
					 .npc(pc),.reg_to_pc(reg_to_pc), .regWrite_select(regWrite_select),
					 .MemRead(MemRead),.MemWrite(MemWrite),.alu_control(alu_control),.ALU_src(ALU_src),.const_src(const_src),.reg_data(reg_data),
					 .immediate_const(immediate_const),.alu_result(alu_result),.zero_flag(zero_flag),.carry_flag(carry_flag),
					 .sign_flag(sign_flag),.overflow_flag(overflow_flag)); 
	//Almost the entire data path is declared in this one module

	
	wire branch_success; //A wire set as a flag in the branch logic module telling the program counter whether to branch or not.
	PC_next PCN(.clk(clk),.rst(rst),.offset(jump_offset),.branch(branch_success),.pc(pc)); // The program counter module
	
	BranchL BL(.clk(clk),.rst(rst),.opcode(opcode),.offset_in(offset),.rs_value(alu_result),.zflag_ff(zero_flag),
				  .cflag_ff(carry_flag),.oflag_ff(overflow_flag),.sflag_ff(sign_flag),.branch(branch_success),.offset_out(jump_offset)); // The branch logic module which essentialssy defines the offset
					// and sets the branch_success flag.
	
endmodule
