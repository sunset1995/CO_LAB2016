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
		input        reset,
		input        clk,
		input  [7:0] select1,
		input  [7:0] select2,
		input        writeBack,
		input  [7:0] writeBackData,
		output [7:0] out1,
		output [7:0] out2,
		output [7:0] reg1,
		output [7:0] reg2,
		output [7:0] reg3,
		output [7:0] reg4
		); 


reg    [7:0] register [3:0];

assign reg1 = register[0];
assign reg2 = register[1];
assign reg3 = register[2];
assign reg4 = register[3];
assign out1 = register[select1[1:0]];
assign out2 = register[select2[1:0]];

always @( posedge clk ) begin
	if( reset ) begin
		register[0] <= 8'd0;
		register[1] <= 8'd0;
		register[2] <= 8'd0;
		register[3] <= 8'd0;
	end
	else if( writeBack ) begin
		register[select1[1:0]] <= writeBackData;
	end
	else begin
		register[select1[1:0]] <= register[select1];
	end
end


endmodule
