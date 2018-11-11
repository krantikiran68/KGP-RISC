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

// The module dedicated to deciding the branching
//outputs the offset and whethera branch has to be taken
module BranchL(
	input wire [5:0] opcode,
	input wire [25:0] offset_in,
	input wire [31:0] rs_value,
	input wire zflag_ff,input wire oflag_ff,
	input wire cflag_ff,
	input wire sflag_ff,
	input wire clk,
	output reg [25:0] offset_out,
	input wire rst,
	output reg branch
    );
	
	wire zflag, oflag, cflag, sflag;
	DFlipFlop zFlagFF (.clk(clk),.rst(rst),.in(zflag_ff),.out(zflag)),
				 oFlagFF (.clk(clk),.rst(rst),.in(oflag_ff),.out(oflag)),
				 cFlagFF (.clk(clk),.rst(rst),.in(cflag_ff),.out(cflag)),
				 sFlagFF (.clk(clk),.rst(rst),.in(sflag_ff),.out(sflag)); // Dflipflops to preserve the flags for accurate branching

//	always@(posedge clk or posedge rst)
	always @(opcode or offset_in or rs_value or zflag or oflag or cflag or sflag or rst)
	begin
		if(rst)
		begin
			offset_out = 0;//reset signal
			branch = 0;
		end
		else
		begin
			branch = 1;
			case(opcode)
				6'd3: begin 						// unconditional jump
					offset_out = offset_in;
				end
				6'd4: begin 						// jump to register value
					offset_out = rs_value[25:0];
				end
				6'd5: begin 						// branch on zero
					if(zflag)
						offset_out = offset_in;
					else begin 						// branch condition fails
						branch = 0;
						offset_out = 0;
					end
				end
				6'd6: begin 						// branch on not zero
					if(!zflag)
						offset_out = offset_in;
					else begin 						// branch condition fails
						branch = 0;
						offset_out = 0;
					end
				end
				6'd7: begin							// branch on carry flag
					if(cflag)
						offset_out = offset_in;
					else begin 						// branch condition fails
						branch = 0;
						offset_out = 0;
					end
				end
				6'd8: begin 						// branch on not carry
					if(!cflag)
						offset_out = offset_in;
					else begin						// branch condition fails
						branch = 0;
						offset_out = 0;
					end
				end
				6'd9: begin 						// branch on sign flag, i.e negative number
					if(sflag)
						offset_out = offset_in; 	
					else begin						// branch condition fails
						branch = 0;
						offset_out = 0;
					end
				end
				6'd10: begin 						// branch on not sign, i.e non negative number
					if(!sflag)
						offset_out = offset_in;
					else begin 						// branch condition fails
						branch = 0;
						offset_out = 0;
					end
				end
				6'd11: begin 						// branch on overflow
					if(oflag)
						offset_out = offset_in;
					else begin 						// branch condition fails
						branch = 0;
						offset_out = 0;
					end
				end
				6'd12: begin 						// branch on not overflow
					if(!oflag)
						offset_out = offset_in;
					else begin 						// branch condition fails
						branch = 0;
						offset_out = 0;
					end
				end
				6'd13: begin 						// function call
					offset_out = offset_in;
				end
				6'd14: begin 						// return - jump to (ra)
					offset_out = rs_value[25:0];
				end
				default: begin 					// default vaule - no branch and 0 offset
					branch = 0;
					offset_out = 0;
				end
			endcase
		end
	end


endmodule
