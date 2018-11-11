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

module Data_memory_tb;

	// Inputs
	reg clk;
	reg rst;
	reg [9:0] address;
	reg [31:0] data_in;
	reg MemRead;
	reg MemWrite;

	// Outputs
	wire [31:0] data_out;

	// Instantiate the Unit Under Test (UUT)
	Data_memory uut (
		.clk(clk), 
		.rst(rst), 
		.address(address), 
		.data_in(data_in), 
		.MemRead(MemRead), 
		.MemWrite(MemWrite), 
		.data_out(data_out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		address = 0;
		data_in = 0;
		MemRead = 0;
		MemWrite = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		rst = 1;
		#10 rst = 0;

		#10;
		address = 12;
		data_in = 32'd798;
		MemRead = 1;
		MemWrite = 0;

		#10;
		address = 9;
		data_in = 32'd748;
		MemRead = 0;
		MemWrite = 1;

		#10;
		address = 14;
		data_in = 32'd543;
		MemRead = 0;
		MemWrite = 0;


		// A sequence of steps in which the same register is exploited
		#10;
		address = 0;
		data_in = 32'd2;
		MemRead = 1;
		MemWrite = 0;

		#10;
		address = 0;
		data_in = 32'd2;
		MemRead = 0;
		MemWrite = 1;

		#10;
		address = 0;
		data_in = 32'd2;
		MemRead = 1;
		MemWrite = 0;

	end
     always
     begin
     	#5 clk = ~clk;
     end
endmodule

