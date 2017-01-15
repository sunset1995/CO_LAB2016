`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:21:50 01/14/2017 
// Design Name: 
// Module Name:    decoder 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module decoder(
	input  [3:0] opcode,
	output       writeBack,
	output       selectConst,
	output [2:0] alu_op
	);


assign writeBack   = (opcode    != 4'b0000);
assign selectConst = (opcode[0] == 1'b1);
assign alu_op      = opcode[3:1];


endmodule
