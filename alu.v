`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:32:09 01/15/2017 
// Design Name: 
// Module Name:    alu 
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
module alu(
	input  [2:0] alu_op,
	input  [7:0] data1,
	input  [7:0] data2,
	output [7:0] ans,
	output       overflow,
	output       zeroflag
	);


wire [7:0] result_add = (data1 + data2);
wire [7:0] result_sub = (data1 - data2);
wire [7:0] result_and = (data1 & data2);
wire [7:0] result_or  = (data1 | data2);
wire [7:0] result_xor = (data1 ^ data2);
wire [7:0] result_not = (~data1);
assign     ans = (alu_op[2] ?
					(alu_op[1] ?
						(alu_op[0] ? result_and : result_or)
						: (alu_op[0] ? result_xor : result_not))
					: (alu_op[1] ? result_sub : result_add)
					);


endmodule
