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

module Register_Bank_tb;

	// Inputs
	reg clk;
	reg rst;
	reg regWriteEnable;
	reg [31:0] regWriteData;
	reg [4:0] regAddr_1;
	reg [4:0] regAddr_2;

	// Outputs
	wire [31:0] regReadData_1;
	wire [31:0] regReadData_2;

	// Instantiate the Unit Under Test (UUT)
	RegisterBank uut (
		.clk(clk), 
		.rst(rst), 
		.regWriteEnable(regWriteEnable), 
		.regWriteData(regWriteData), 
		.regAddr_1(regAddr_1), 
		.regReadData_1(regReadData_1), 
		.regAddr_2(regAddr_2), 
		.regReadData_2(regReadData_2)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		regWriteEnable = 0;
		regWriteData = 0;
		regAddr_1 = 0;
		regAddr_2 = 0;

		// Wait 100 ns for global reset to finish
		#100;
      rst = 1;
		#10;
		rst = 0;
		
		#10;
		regWriteEnable = 0;
		regWriteData = 143434;
		regAddr_1 = 28;
		regAddr_2 = 30;
		
		#10;
		regWriteEnable = 1;
		regWriteData = 143434;
		regAddr_1 = 28;	
		regAddr_2 = 30;
		
		#10
		regWriteEnable = 1;
		regWriteData = 143434;
		regAddr_1 = 30;
		regAddr_2 = 28;
		// Add stimulus here

	end
    always begin
		#5 clk = ~clk;
	end
endmodule

