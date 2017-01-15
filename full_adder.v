`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:53:05 01/15/2017 
// Design Name: 
// Module Name:    full_adder 
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
module full_adder(
	input a,
	input b,
	input cIn,
	output s,
	output cOut
	);


assign s    = (a ^ b ^ cIn);
assign cOut = ((a&b) | (a&cIn) | (b&cIn));


endmodule
