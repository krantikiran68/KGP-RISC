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

module Instruction_decoder_tb;

	// Inputs
	reg [31:0] instruction;

	// Outputs
	wire [5:0] opcode;
	wire [4:0] reg_addr_1;
	wire [4:0] reg_addr_2;
	wire [4:0] shift_amount;
	wire [10:0] opcode_ext;
	wire [21:0] immediate_const;
	wire [25:0] offset;

	// Instantiate the Unit Under Test (UUT)
	InstructionDecoder uut (
		.instruction(instruction), 
		.opcode(opcode), 
		.reg_addr_1(reg_addr_1), 
		.reg_addr_2(reg_addr_2), 
		.shift_amount(shift_amount), 
		.opcode_ext(opcode_ext), 
		.immediate_const(immediate_const), 
		.offset(offset)
	);

	initial begin
		// Initialize Inputs
		instruction = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

		#10 instruction = 32'h000000000;
		#10 instruction = 32'h01013b067;
		#10 instruction = 32'h01013b067;
		#10 instruction = 32'h01013b067;
		#10 instruction = 32'h0013b067;
		
		#10 instruction = 32'ha1013b067;
		#10 instruction = 32'h11013b067;
		#10 instruction = 32'h81013b067;
		#10 instruction = 32'h1013b067;
		#10 instruction = 32'h81013b067;

	end
      
endmodule

