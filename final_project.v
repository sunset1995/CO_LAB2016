`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:53:42 01/05/2017 
// Design Name: 
// Module Name:    final_project 
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
module final_project( input clk, input reset, output signed [7:0] reg1, output signed [7:0] reg2, output signed [7:0] reg3, output signed [7:0] reg4 );

wire [19:0] instruction;

pc_instruction pc_instruction( .clk(clk), .hold(1'b0), .reset(reset), .instruction(instruction) );
data_memory data_memory( .reset(reset), .clk(clk), .reg1(reg1), .reg2(reg2), .reg3(reg3), .reg4(reg4) ); // if you need more I/O you can add more

endmodule
