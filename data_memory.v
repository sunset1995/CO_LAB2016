`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:46:11 01/05/2017 
// Design Name: 
// Module Name:    data_memory 
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
module data_memory( 
		input reset,
		input clk,
		output [7:0] reg1,
		output [7:0] reg2,
		output [7:0] reg3,
		output [7:0] reg4
		// if you need more I/O you can add more here
		
		); 

reg    [7:0] register [3:0];

assign reg1 = register[0];
assign reg2 = register[1];
assign reg3 = register[2];
assign reg4 = register[3];

/*
	You need to put your code here
*/

endmodule
