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

module bram_tb;

	// Inputs
	reg clka;
	reg rsta;
	reg ena;
	reg [0:0] wea;
	reg [4:0] addra;
	reg [31:0] dina;

	// Outputs
	wire [31:0] douta;

	// Instantiate the Unit Under Test (UUT)
	blk_mem_gen_v7_3 uut (
		.clka(clka), 
		.rsta(rsta), 
		.ena(ena), 
		.wea(wea), 
		.addra(addra), 
		.dina(dina), 
		.douta(douta)
	);

	initial begin
		// Initialize Inputs
		clka = 0;
		rsta = 1;
		ena = 1;
		wea = 0;
		addra = 0;
		dina = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#10 rsta = 0;
		#10 addra = 1;
		#10 addra = 2;
		#10 addra = 3;

	end
	always begin
		#5 clka = ~clka;
   end
endmodule

