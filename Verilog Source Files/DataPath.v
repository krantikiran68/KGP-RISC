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

// The main datapath module
module DataPath( input wire clk, input wire rst, input wire regWriteEnable, input wire[4:0] regAddr_1, input wire[4:0] regAddr_2,  input wire [4:0] shift_amount,
					  input wire [31:0] npc, input wire reg_to_pc, input wire regWrite_select,
					  input wire MemRead, input wire MemWrite, input wire [3:0] alu_control, input wire ALU_src,input wire const_src, input wire reg_data,
					  input wire [20:0] immediate_const, output wire [31:0] alu_result, output wire zero_flag, output wire carry_flag,
					  output wire sign_flag, output wire overflow_flag);

// const_src is the flag that is given to the second MUX to the ALU's input. It selects between the constant input and the output ftom the MUX that selects register data and shift amount

// reg_to_pc is the flag that selects which offset is being used to go for the branch. Used explicitly for function calls and return

// reg_data selects the source from which data is about to be eritten to the registers.

	wire[31:0] memDataOut;// the output from the Data memory
	wire[31:0] alu_result_temp; // a temporary input to the muxs and is the alu's result
	wire[31:0] regWriteData, regReadData_1, regReadData_2; // Register Bank and Data Memory data Buses
	wire[31:0] regWriteData_temp;   // output of mux from alu/ data memory -> reg bank

	// The data memory module
		Data_memory dm(.clk(clk), .rst(rst),.address(alu_result_temp),.data_in(regReadData_2),.MemRead(MemRead),
						.MemWrite(MemWrite),.data_out(memDataOut));
	
	//Some muxes in the datapath 
	Mux_32b_2x1 reg_input(.a(memDataOut),.b(alu_result_temp),.select(reg_data),.out(regWriteData_temp));
	Mux_32b_2x1 regBank_pc_input(.a(regWriteData_temp),.b(npc),.select(reg_to_pc),.out(regWriteData));

	wire [4:0] reg_Addr_1_final; // the fianl input to the register bank and the output of a MUX

	Mux_5b_2x1 regBank_addr_input (.a(regAddr_1),.b(5'b11111),.select(reg_to_pc),.out(reg_Addr_1_final));
	
	//Declaration of the reister BAnk
	wire [4:0] regWriteAddr;
	Mux_5b_2x1 regWriteAddr_select (.a(regAddr_1),.b(regAddr_2),.select(regWrite_select),.out(regWriteAddr));
	RegisterBank RB(.clk(clk),.rst(rst),.regWriteEnable(regWriteEnable),.regWriteData(regWriteData), .regWriteAddr(regWriteAddr),
					 .regAddr_1(reg_Addr_1_final),.regAddr_2(regAddr_2),.regReadData_1(regReadData_1),.regReadData_2(regReadData_2));
	
	
	wire [31:0] alu_input_2, alu_const_input;

	//MUXes controlling the ALU's datapath
	Mux_32b_2x1 alu_constant (.a({{11{immediate_const[20]}},immediate_const}),.b({27'b0,shift_amount}),.select(const_src),.out(alu_const_input)); 
	// const_src - from control unit to select whether the alu input is shift amount or immediate constant
	Mux_32b_2x1 alu_input_mux(.a(regReadData_2),.b(alu_const_input),.select(ALU_src),.out(alu_input_2));
	
	// The ALU
	ALU alu(.a(regReadData_1),.b(alu_input_2),.control(alu_control),.result(alu_result_temp),.zero_flag(zero_flag),
				.carry_flag(carry_flag),.sign_flag(sign_flag),.overflow_flag(overflow_flag));

	// Assigning the ouput of the MUX to the ALU result
	assign alu_result = alu_result_temp;

endmodule
