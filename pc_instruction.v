`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:16:10 01/05/2017 
// Design Name: 
// Module Name:    pc_instruction 
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
module pc_instruction( input clk, input hold, input reset, output [19:0] instruction );

reg [4:0]  pc;
reg [19:0] data [31:0];

assign instruction = data [ pc ];

always @( posedge clk )begin
	if ( reset )begin
		pc <= 0;
		data[0]  <= 20'b00001111111101111110; // null
		data[1]  <= 20'b00110000000010001111; // addi R1, -113
		data[2]  <= 20'b00110000001000011011; // addi R3, 27
		data[3]  <= 20'b00100000000000000010; // add  R1, R3
		data[4]  <= 20'b00000000000000000000; // null
		data[5]  <= 20'b00110000000111111010; // addi R2, -6
		data[6]  <= 20'b00000000000000000000; // null
		data[7]  <= 20'b00110000001100100111; // addi R4, 39
		data[8]  <= 20'b01000000000000000001; // sub  R1, R2
		data[9]  <= 20'b11100000000000000011; // and  R1, R4
		data[10] <= 20'b00000000000000000000; // null
		data[11] <= 20'b11000000000000000010; // or   R1, R3
		data[12] <= 20'b10000000001000000000; // not  R3
		data[13] <= 20'b10100000001000000011; // xor  R3, R4
		data[14] <= 20'b01010000001100001010; // subi R4, 10
		data[15] <= 20'b00000000000000000000; // null
		data[16] <= 20'b00000000000000000000; // null
		data[17] <= 20'b11100000001100000000; // and R4, R1
		data[18] <= 20'b00000000000000000000; // null
		data[19] <= 20'b00000000000000000000; // null
		data[20] <= 20'b00000000000000000000; // null
		data[21] <= 20'b00000000000000000000; // null
		data[22] <= 20'b11100000000000000011; // and R1, R4
		data[23] <= 20'b00000000000000000000; // null
		data[24] <= 20'b00000000000000000000; // null
	end
	else if ( hold )begin
		pc <= pc;
	end
	else if ( pc != 5'd24 )begin
		pc <= pc + 1;
	end
	else begin
		pc <= pc;
	end
end

endmodule
