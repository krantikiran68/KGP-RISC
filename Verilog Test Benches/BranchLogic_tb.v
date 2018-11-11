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

module BranchLogic_tb;

	// Inputs
	reg [5:0] opcode;
	reg [25:0] offset_in;
	reg [31:0] rs_value;
	reg zflag_ff;
	reg oflag_ff;
	reg cflag_ff;
	reg sflag_ff;
	reg clk;
	reg rst;

	// Outputs
	wire [25:0] offset_out;
	wire branch;

	// Instantiate the Unit Under Test (UUT)
	BranchL uut (
		.opcode(opcode), 
		.offset_in(offset_in), 
		.rs_value(rs_value), 
		.zflag_ff(zflag_ff), 
		.oflag_ff(oflag_ff), 
		.cflag_ff(cflag_ff), 
		.sflag_ff(sflag_ff), 
		.clk(clk), 
		.offset_out(offset_out), 
		.rst(rst), 
		.branch(branch)
	);

	initial begin
		// Initialize Inputs
		opcode = 0;
		offset_in = 0;
		rs_value = 0;
		zflag_ff = 0;
		oflag_ff = 0;
		cflag_ff = 0;
		sflag_ff = 0;
		clk = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		rst = 1;
		#10 rst = 0;

		#10;
		//Zero flag no branch
		opcode = 6'd5;
		offset_in = 4;
		rs_value = -32;
		zflag_ff = 1;
		oflag_ff = 0;
		cflag_ff = 0;
		sflag_ff = 0;

		#10;
		//Zero flag branch
		opcode = 6'd0;
		offset_in = 0;
		rs_value = -32;
		zflag_ff = 1;
		oflag_ff = 0;
		cflag_ff = 0;
		sflag_ff = 0;

		#10;
		//Sign flag no branch
		opcode = 6'd9;
		offset_in = 0;
		rs_value = -32;
		zflag_ff = 0;
		oflag_ff = 0;
		cflag_ff = 0;
		sflag_ff = 1;

		#10;
		//Sign flag branch
		opcode = 6'd5;
		offset_in = 0;
		rs_value = -32;
		zflag_ff = 0;
		oflag_ff = 0;
		cflag_ff = 0;
		sflag_ff = 1;

		#10;
		//Carry flag no branch
		opcode = 6'd7;
		offset_in = 0;
		rs_value = -32;
		zflag_ff = 0;
		oflag_ff = 0;
		cflag_ff = 1;
		sflag_ff = 0;

		
		#10;
		//Carry flag branch
		opcode = 6'd1;
		offset_in = 8;
		rs_value = -32;
		zflag_ff = 0;
		oflag_ff = 0;
		cflag_ff = 1;
		sflag_ff = 0;

		#10;
		//Overflow flag no branch
		opcode = 6'd11;
		offset_in = 0;
		rs_value = -32;
		zflag_ff = 0;
		oflag_ff = 1;
		cflag_ff = 0;
		sflag_ff = 0;

		#10;
		//Overflow flag branch
		opcode = 6'd0;
		offset_in = 0;
		rs_value = -32;
		zflag_ff = 0;
		oflag_ff = 1;
		cflag_ff = 0;
		sflag_ff = 0;

		#10;
		//opcode
		opcode = 6'd3;
		offset_in = 0;
		rs_value = 12;
		zflag_ff = 0;
		oflag_ff = 1;
		cflag_ff = 0;
		sflag_ff = 0;

		#10;
		opcode = 6'd13;
		offset_in = 20;
		rs_value = 16;
		zflag_ff = 0;
		oflag_ff = 1;
		cflag_ff = 0;
		sflag_ff = 0;

	end
    
    always begin
    	#5 clk = ~clk;
    end 

endmodule

