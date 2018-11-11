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

//The ALU Module!
//A purely combinational module
//recieves control instruction form the Control UNit
module ALU(input wire [31:0] a, input wire [31:0] b, input wire [3:0] control, output reg [31:0] result,output reg zero_flag,
				output reg carry_flag, output reg sign_flag, output reg overflow_flag);

	always @(a or b or control)
	begin
		carry_flag = 0;// Setting all flags to zero initially
		zero_flag = 0;
		sign_flag =0;
		overflow_flag = 0;
		case(control)
			4'b0000: {carry_flag,result} = a+b;//Addition. And addition is the only operation with the chance of generating a carry
			4'b0001: result = ~b+1;//Compliment
			4'b0010: result = a&b;//And operation
			4'b0011: result = a^b;//Or operation
			4'b0100: result = a<<b;//Left shift
			4'b0101: result = a>>b;//Right shift
			4'b0110: result = a>>>b;// Sign preserve right shift
			4'b0111: result = a;// Bypass the ALU. Operation important for branching
			4'b1000: result = b;// Bypass the ALU. Operation important for branching
			4'b1001: result = a + b[15:0]; 	// Add LSB side half word for calculating memory offset
			default:  result = 32'd0; // Default does nothing
		endcase
		zero_flag = (result == 32'd0)?1:0;// If result is zero the set zero flag
		sign_flag = result[31]; // the sign flag is the sign bit of the result
		overflow_flag = carry_flag^(result[31]^(a[31]^b[31])); // the overflow flag
	end	

endmodule
