`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:54:11 01/15/2017 
// Design Name: 
// Module Name:    adder_8bits 
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
module adder_8bits(
	input  [7:0] in1,
	input  [7:0] in2,
	output [7:0] sum,
	output       c
	);


wire [7:0] carry;
assign     c = carry[7];

full_adder fa1(.a(in1[0]), .b(in2[0]), .cIn(1'b0), .s(sum[0]), .cOut(carry[0]));
full_adder fa2(.a(in1[1]), .b(in2[1]), .cIn(carry[0]), .s(sum[1]), .cOut(carry[1]));
full_adder fa3(.a(in1[2]), .b(in2[2]), .cIn(carry[1]), .s(sum[2]), .cOut(carry[2]));
full_adder fa4(.a(in1[3]), .b(in2[3]), .cIn(carry[2]), .s(sum[3]), .cOut(carry[3]));
full_adder fa5(.a(in1[4]), .b(in2[4]), .cIn(carry[3]), .s(sum[4]), .cOut(carry[4]));
full_adder fa6(.a(in1[5]), .b(in2[5]), .cIn(carry[4]), .s(sum[5]), .cOut(carry[5]));
full_adder fa7(.a(in1[6]), .b(in2[6]), .cIn(carry[5]), .s(sum[6]), .cOut(carry[6]));
full_adder fa8(.a(in1[7]), .b(in2[7]), .cIn(carry[6]), .s(sum[7]), .cOut(carry[7]));


endmodule
