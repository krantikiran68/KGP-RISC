`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
/*
Assignment No - 7
Semester - Autumn 2018
Group - 3
Members:
  G Rahul Kranti Kiran - 16CS10018
  Sai Saketh Aluru - 16CS30030
*/ 
////////////////////////////////////////////////////////////////////////////////

module DataPath_tb;

	// Inputs
	reg clk;
	reg rst;
	reg regWriteEnable;
	reg [4:0] regAddr_1;
	reg [4:0] regAddr_2;
	reg [4:0] shift_amount;
	reg [31:0] npc;
	reg reg_to_pc;
	reg regWrite_select;
	reg MemRead;
	reg MemWrite;
	reg [3:0] alu_control;
	reg ALU_src;
	reg const_src;
	reg reg_data;
	reg [20:0] immediate_const;

	// Outputs
	wire [31:0] alu_result;
	wire zero_flag;
	wire carry_flag;
	wire sign_flag;
	wire overflow_flag;

	// Instantiate the Unit Under Test (UUT)
	DataPath uut (
		.clk(clk), 
		.rst(rst), 
		.regWriteEnable(regWriteEnable), 
		.regAddr_1(regAddr_1), 
		.regAddr_2(regAddr_2), 
		.shift_amount(shift_amount), 
		.npc(npc), 
		.reg_to_pc(reg_to_pc), 
		.regWrite_select(regWrite_select), 
		.MemRead(MemRead), 
		.MemWrite(MemWrite), 
		.alu_control(alu_control), 
		.ALU_src(ALU_src), 
		.const_src(const_src), 
		.reg_data(reg_data), 
		.immediate_const(immediate_const), 
		.alu_result(alu_result), 
		.zero_flag(zero_flag), 
		.carry_flag(carry_flag), 
		.sign_flag(sign_flag), 
		.overflow_flag(overflow_flag)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		regWriteEnable = 0;
		regAddr_1 = 0;
		regAddr_2 = 0;
		shift_amount = 0;
		npc = 0;
		reg_to_pc = 0;
		regWrite_select = 0;
		MemRead = 0;
		MemWrite = 0;
		alu_control = 0;
		ALU_src = 0;
		const_src = 0;
		reg_data = 0;
		immediate_const = 0;

		// Wait 100 ns for global reset to finish
		#100;
      #10 rst = 1;
		#10 rst = 0;
		// Add stimulus here

		#10;
		regWriteEnable = 1;
		regAddr_1 = 12;
		regAddr_2 = 14;
		shift_amount = 10;
		npc = 20;
		reg_to_pc = 0;
		regWrite_select = 1;
		MemRead = 0;
		MemWrite = 0;
		alu_control = 0;
		ALU_src = 0;
		const_src = 1;
		reg_data = 0;
		immediate_const = 0;

		#10;
		regWriteEnable = 1;
		regAddr_1 = 20;
		regAddr_2 = 30;
		shift_amount = 1;
		npc = 48;
		reg_to_pc = 1;
		regWrite_select = 1;
		MemRead = 1;
		MemWrite = 0;
		alu_control = 2;
		ALU_src = 1;
		const_src = 0;
		reg_data = 1;
		immediate_const = 0;

		#10;
		regWriteEnable = 1;
		regAddr_1 = 20;
		regAddr_2 = 16;
		shift_amount = 0;
		npc = 24;
		reg_to_pc = 1;
		regWrite_select = 1;
		MemRead = 1;
		MemWrite = 0;
		alu_control = 2;
		ALU_src = 0;
		const_src = 0;
		reg_data = 1;
		immediate_const = 0;
		
		#10;
		regWriteEnable = 1;
		regAddr_1 = 20;
		regAddr_2 = 30;
		shift_amount = 1;
		npc = 48;
		reg_to_pc = 1;
		regWrite_select = 1;
		MemRead = 1;
		MemWrite = 0;
		alu_control = 2;
		ALU_src = 1;
		const_src = 0;
		reg_data = 1;
		immediate_const = 0;

		#10;
		regWriteEnable = 1;
		regAddr_1 = 20;
		regAddr_2 = 30;
		shift_amount = 1;
		npc = 48;
		reg_to_pc = 1;
		regWrite_select = 1;
		MemRead = 0;
		MemWrite = 1;
		alu_control = 7;
		ALU_src = 1;
		const_src = 0;
		reg_data = 1;
		immediate_const = 40;

		#10;
		regWriteEnable = 0;
		regAddr_1 = 1;
		regAddr_2 = 30;
		shift_amount = 1;
		npc = 32;
		reg_to_pc = 0;
		regWrite_select = 1;
		MemRead = 0;
		MemWrite = 1;
		alu_control = 2;
		ALU_src = 1;
		const_src = 0;
		reg_data = 0;
		immediate_const = 20;
	end
   always begin
	#5 clk = ~clk;
	end
endmodule

