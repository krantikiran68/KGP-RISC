`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
/*
Assignment No - 7
Semester - Autumn 2018
Group - 3
Members:
  G Rahul KrantiKiran - 16CS10018
  Sai Saketh Aluru - 16CS30030
*/
//////////////////////////////////////////////////////////////////////////////////

//The data memory module
module Data_memory(input wire clk, input wire rst, input wire [9:0] address,
						 input wire [31:0] data_in, input wire MemRead, input wire MemWrite,
						 output wire [31:0] data_out);

reg [31:0] Memory[1023:0];
integer i;
always @(posedge clk or posedge rst)
begin
	if(rst)
	begin
		for(i=0;i<1024;i=i+1)
			Memory[i] = 32'd0;
		// Initialise Array for sorting here. Ignore for other codes
		Memory[0] = 32'd2;
		Memory[1] = 32'd3;
		Memory[2] = 32'd1;
		Memory[3] = 32'd4;
		Memory[4] = 32'd8;
		Memory[5] = 32'd5;
		Memory[6] = 32'd7;
		Memory[7] = 32'd6;
	end
	else
	begin
		if(MemWrite)
			Memory[address] = data_in;//Write to memory
	end
end

		assign data_out = (MemRead)?Memory[address[3:0]]:32'b0;//read form memory
		
endmodule
