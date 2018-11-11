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

// the control unit module
//This takes as input the opcode and opcode ext and instructs all other modules

module ControlUnit(input wire[5:0] opcode, input wire [10:0] opcode_ext,
		input wire clk, input wire rst,
		output reg [3:0] alu_control,
		output reg Branch,regWrite,MemWrite,MemRead,ALU_src,reg_data,const_src,reg_to_pc, regWrite_select
	);

	always@(opcode or opcode_ext or rst)
	begin
		if(rst) // setting all flags to zero
		begin
			alu_control <= 0;
			Branch <= 0;
			regWrite <= 0;
			MemWrite <= 0;
			MemRead <= 0;
			ALU_src <= 0;
			const_src <= 0;
			reg_data <= 0;
			reg_to_pc <= 0;
			regWrite_select <= 0;
		end
		else
		begin
			case(opcode)
				6'd0: 									// R-type instruction
					begin
						case(opcode_ext)
							11'd0:						// Add
								begin
									alu_control <= 0;
									Branch <= 0;
									regWrite <= 1;
									MemWrite <= 0;
									MemRead <= 0;
									const_src <= 0;
									ALU_src <= 0;
									reg_data <= 1;
									reg_to_pc <= 0;
									regWrite_select <= 0;
								end
							11'd1: 						// Complement
								begin
									alu_control <= 1;
									Branch <= 0;
									regWrite <= 1;
									MemWrite <= 0;
									const_src <= 0;
									MemRead <= 0;
									ALU_src <= 0;
									reg_data <= 1;
									reg_to_pc <= 0;
									regWrite_select <= 0;
								end
							11'd2: 						// And
								begin
									alu_control <= 2;
									Branch <= 0;
									regWrite_select <= 0;
									regWrite <= 1;
									const_src <= 0;
									MemWrite <= 0;
									MemRead <= 0;
									ALU_src <= 0;
									reg_data <= 1;
									reg_to_pc <= 0;
								end
							11'd3: 						// Xor
								begin
									alu_control <= 3;
									Branch <= 0;
									const_src <= 0;
									regWrite <= 1;
									MemWrite <= 0;
									MemRead <= 0;
									regWrite_select <= 0;
									ALU_src <= 0;
									reg_data <= 1;
									reg_to_pc <= 0;
								end
							11'd4: 						// Shift Left logical
								begin
									alu_control <= 4;
									Branch <= 0;
									regWrite <= 1;
									MemWrite <= 0;
									MemRead <= 0;
									regWrite_select <= 0;
									const_src <= 1;
									ALU_src <= 1;
									reg_data <= 1;
									reg_to_pc <= 0;
								end
							11'd5: 						// Shift Right Logical
								begin
									alu_control <= 5;
									Branch <= 0;
									regWrite <= 1;
									MemWrite <= 0;
									MemRead <= 0;
									const_src <= 1;
									ALU_src <= 1;
									regWrite_select <= 0;
									reg_data <= 1;
									reg_to_pc <= 0;
								end
							11'd6:  						// Shift Left Variable
								begin
									alu_control <= 4;
									Branch <= 0;
									regWrite <= 1;
									const_src <= 0;
									regWrite_select <= 0;
									MemWrite <= 0;
									MemRead <= 0;
									ALU_src <= 0;
									reg_data <= 1;
									reg_to_pc <= 0;
								end
							11'd7:  						// Shift Right Variable
								begin
									alu_control <= 5;
									Branch <= 0;
									regWrite <= 1;
									MemWrite <= 0;
									const_src <= 0;
									MemRead <= 0;
									ALU_src <= 0;
									reg_data <= 1;
									regWrite_select <= 0;
									reg_to_pc <= 0;
								end
							11'd8:  						// Shift Right Arithmetic
								begin
									alu_control <= 6;
									Branch <= 0;
									regWrite <= 1;
									MemWrite <= 0;
									const_src <= 1;
									MemRead <= 0;
									ALU_src <= 1;
									regWrite_select <= 0;
									reg_data <= 1;
									reg_to_pc <= 0;
								end
							11'd9: 						// Shift Right Arithmetic Variable
								begin
									alu_control <= 6;
									Branch <= 0;
									regWrite <= 1;
									regWrite_select <= 0;
									const_src <= 0;
									MemWrite <= 0;
									MemRead <= 0;
									ALU_src <= 0;
									reg_data <= 1;
									reg_to_pc <= 0;
								end
							default: 
								begin
								end
						endcase
					end
				6'd1: 						        // Load Word
					begin
						alu_control <= 9;
						Branch <= 0;
						regWrite <= 1;
						MemWrite <= 0;
						const_src <= 0;
						regWrite_select <= 1;
						MemRead <= 1;
						ALU_src <= 1;
						reg_data <= 0;
						reg_to_pc <= 0;
					end
				6'd2: 						        // Store Word
					begin
						alu_control <= 9;
						Branch <= 0;
						regWrite <= 0;
						const_src <= 0;
						MemWrite <= 1;
						MemRead <= 0;
						regWrite_select <= 1;
						ALU_src <= 1;
						reg_data <= 0;
						reg_to_pc <= 0;
					end
				6'd3: 						        // Unconditional branch
					begin
						alu_control <= 8;
						Branch <= 1;
						regWrite <= 0;
						regWrite_select <= 0;
						const_src <= 0;
						MemWrite <= 0;
						MemRead <= 0;
						ALU_src <= 1;
						reg_to_pc <= 0;
						reg_data <= 0;
					end
				6'd4: 						        // Branch to register
					begin
						alu_control <= 7;
						Branch <= 1;
						regWrite <= 0;
						const_src <= 0;
						regWrite_select <= 0;
						MemWrite <= 0;
						MemRead <= 0;
						ALU_src <= 0;
						reg_to_pc <= 0;
						reg_data <= 0;
					end
				6'd5: 						        // Branch on zero
					begin
						alu_control <= 8;
						Branch <= 1;
						regWrite <= 0;
						const_src <= 0;
						regWrite_select <= 0;
						MemWrite <= 0;
						MemRead <= 0;
						ALU_src <= 1;
						reg_to_pc <= 0;
						reg_data <= 0;
					end
				6'd6: 						        // Branch on not zero
					begin
						alu_control <= 8;
						Branch <= 1;
						regWrite <= 0;
						const_src <= 0;
						regWrite_select <= 0;
						MemWrite <= 0;
						MemRead <= 0;
						ALU_src <= 1;
						reg_to_pc <= 0;
						reg_data <= 0;
					end
				6'd7: 						        // Branch on carry
					begin
						alu_control <= 8;
						Branch <= 1;
						regWrite <= 0;
						regWrite_select <= 0;
						const_src <= 0;
						MemWrite <= 0;
						MemRead <= 0;
						ALU_src <= 1;
						reg_data <= 0;
						reg_to_pc <= 0;
					end
				6'd8: 						        // Branch on not carry
					begin
						alu_control <= 8;
						Branch <= 1;
						regWrite <= 0;
						regWrite_select <= 0;
						const_src <= 0;
						MemWrite <= 0;
						MemRead <= 0;
						ALU_src <= 1;
						reg_to_pc <= 0;
						reg_data <= 0;
					end
				6'd9: 						        // Branch on sign 
					begin
						alu_control <= 8;
						Branch <= 1;
						regWrite <= 0;
						const_src <= 0;
						regWrite_select <= 0;
						MemWrite <= 0;
						MemRead <= 0;
						ALU_src <= 1;
						reg_to_pc <= 0;
						reg_data <= 0;
					end
				6'd10: 						        // Branch on not sign
					begin
						alu_control <= 8;
						regWrite_select <= 0;
						Branch <= 1;
						regWrite <= 0;
						const_src <= 0;
						MemWrite <= 0;
						MemRead <= 0;
						ALU_src <= 1;
						reg_to_pc <= 0;
						reg_data <= 0;
					end
				6'd11: 						        // Branch on overflow
					begin
						alu_control <= 8;
						Branch <= 1;
						regWrite <= 0;
						const_src <= 0;
						regWrite_select <= 0;
						MemWrite <= 0;
						MemRead <= 0;
						reg_to_pc <= 0;
						ALU_src <= 1;
						reg_data <= 0;
					end
				6'd12: 						        // Branch on not overflow
					begin
						alu_control <= 8;
						Branch <= 1;
						regWrite <= 0;
						const_src <= 0;
						reg_to_pc <= 0;
						regWrite_select <= 0;
						MemWrite <= 0;
						MemRead <= 0;
						ALU_src <= 1;
						reg_data <= 0;
					end
				6'd13:  						        // Function call
				  begin
					alu_control <= 0;
					const_src <= 0;
					Branch <= 1;
					regWrite <= 1;
					regWrite_select <= 0;
					MemWrite <= 0;
					MemRead <= 0;
					ALU_src <= 1;
					reg_to_pc <= 1;
					reg_data <= 0;
				end
				6'd14: 
				  begin 						        // Return 
					alu_control <= 7;
					Branch <= 1;
					regWrite <= 0;
					const_src <= 0;
					regWrite_select <= 0;
					MemWrite <= 0;
					MemRead <= 0;
					ALU_src <= 0;
					reg_to_pc <= 1;
					reg_data <= 0;
				end
				6'd15: begin  						  // Add immediate
					alu_control <= 0;
					Branch <= 0;
					regWrite <= 1;
					MemWrite <= 0;
					const_src <= 0;
					regWrite_select <= 0;
					MemRead <= 0;
					ALU_src <= 1;
					reg_data <= 1;
					reg_to_pc <= 0;
				end
				6'd16: begin   						// Complement Immediate
					alu_control <= 1;
					Branch <= 0;
					regWrite <= 1;
					MemRead <= 0;
					MemWrite <= 0;
					regWrite_select <= 0;
					const_src <= 0;
					ALU_src <= 1;
					reg_to_pc <= 0;
					reg_data <= 1;
				end
			endcase
		end
	end
endmodule
