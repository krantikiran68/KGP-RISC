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

//A very basic MUX
module Mux_32b_2x1(input wire [31:0] a, input wire [31:0] b, input wire select, output reg[31:0] out);
	always @(*)
	begin 
		if(select)
			out = b;
		else out = a;
	end
endmodule
