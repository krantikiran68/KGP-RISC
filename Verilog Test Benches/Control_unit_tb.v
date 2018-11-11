`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
/*
Assignment No - 7
Semester - Autumn 2018
Group - 3
Members:
  G Rahul KrantiKiran - 16CS10018
  Sai Saketh Aluru - 16CS30030
*/
////////////////////////////////////////////////////////////////////////////////

module Control_unit_tb;

	// Inputs
	reg [5:0] opcode;
	reg [10:0] opcode_ext;
	reg clk;
	reg rst;

	// Outputs
	wire [3:0] alu_control;
	wire Branch;
	wire regWrite;
	wire MemWrite;
	wire MemRead;
	wire ALU_src;
	wire reg_data;
	wire const_src;

	// Instantiate the Unit Under Test (UUT)
	ControlUnit uut (
		.opcode(opcode), 
		.opcode_ext(opcode_ext), 
		.clk(clk), 
		.rst(rst), 
		.alu_control(alu_control), 
		.Branch(Branch), 
		.regWrite(regWrite), 
		.MemWrite(MemWrite), 
		.MemRead(MemRead), 
		.ALU_src(ALU_src), 
		.reg_data(reg_data), 
		.const_src(const_src)
	);

	initial begin
		// Initialize Inputs
		opcode = 0;
		opcode_ext = 0;
		clk = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		#100;
		#10 rst = 1;
		#10 rst = 0;
		
		#10;
		opcode = 0;
		opcode_ext = 0;
      
		#10;
		opcode = 0;
		opcode_ext = 4;
		
		#10;
		opcode = 3;
		opcode_ext = 0;
		
		#10;
		opcode = 4;
		opcode_ext = 0;
		
		#10;
		opcode = 15;
		opcode_ext = 0;
		// Add stimulus here

	end
	
	always begin
		#5 clk = ~clk;
	end      
endmodule

