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

// A very simple module that splits the 32-bit addresse into various parts
module InstructionDecoder( input wire[31:0] instruction, output wire [5:0] opcode, 
									output wire [4:0] reg_addr_1, output wire [4:0] reg_addr_2,
									output wire [4:0] shift_amount, output wire [10:0] opcode_ext,
									output wire [20:0] immediate_const, output wire [25:0] offset);
								
assign opcode = instruction[31:26]; 			// the main opcode
assign reg_addr_1 = instruction[25:21]; 		// the address of the final register
assign reg_addr_2 = instruction[20:16];		// the address of the secondary register
assign shift_amount = instruction[15:11]; 	// the shift amount in case of shift instructions
assign opcode_ext = instruction[10:0]; 		// the opcode extension for arithmetic instructions
assign immediate_const = instruction[20:0];	// the immediate integer constant for load ,store, addi, subi, compi instructions
assign offset = instruction[25:0];				// the offset for unconditional branch

endmodule
