`timescale 1ns / 1ps
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

// A very basic MUX 5 bit inputs
module Mux_5b_2x1(input wire [4:0] a, input wire [4:0] b, input wire select, output reg[4:0] out);
	always @(*)
		begin 
			if(select)
				out = b;
			else out = a;
		end
endmodule
