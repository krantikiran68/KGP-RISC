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
// The program counter module to change the program counter
module PC_next(input wire clk,input wire [25:0] offset,input wire branch, output reg [31:0] pc,input wire rst);
	wire [31:0] pc_next, pc_non_jump, pc_jump;
	always @(posedge clk or posedge rst)
	begin
		if(rst)
		begin
			pc <= 32'd0; 		// reset condition
		end
		else
			pc <= pc_next; 	// set next value of pc
	end
	assign pc_non_jump = pc + 32'd4; 								// calculate pc for non-branching instructions
	assign pc_jump = pc + 32'd4 + {{6{offset[25]}},offset}; 	// calculate pc for branching instructions
	assign pc_next = (branch)? pc_jump: pc_non_jump; 			// Select next pc value
endmodule
