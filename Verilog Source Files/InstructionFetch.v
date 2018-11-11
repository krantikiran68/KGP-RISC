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

// A module to read the input instructions using the BRAM
module InstructionFetch(input wire [31:0] pc,output wire [31:0] instruction,input wire clk,input wire rst);
	wire [4:0] rom_address;
	assign rom_address = pc[6:2];
	blk_mem_gen_v7_3 instruction_memory(.clka(~clk),.rsta(rst),.ena(1'b1),.wea(1'b0),.addra(rom_address),.dina(32'd0),.douta(instruction));
endmodule
