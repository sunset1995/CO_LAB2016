//0317001_0310511
`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:58:01 02/25/2016
// Design Name: 
// Module Name:    alu_top 
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

module alu_top_less(
	src1,       //1 bit source 1 (input)
	src2,       //1 bit source 2 (input)
	less,       //1 bit less     (input)
	A_invert,   //1 bit A_invert (input)
	B_invert,   //1 bit B_invert (input)
	cin,        //1 bit carry in (input)
	ein,        //1 bit equal in (input)
	operation,  //operation      (input)
	result,     //1 bit result   (output)
	cout,       //1 bit carry out(output)
	eout,       //1 bit equal out(output)
	set         //1 bit set output
	);

input src1;
input src2;
input less;
input A_invert;
input B_invert;
input cin;
input ein;
input [2-1:0] operation;

output reg result;
output reg cout;
output reg eout;
output reg set;

wire A_in = src1 ^ A_invert;
wire B_in = src2 ^ B_invert;
wire AND  = A_in & B_in;
wire OR   = A_in | B_in;
wire ADD  = A_in ^ B_in ^ cin;
wire tmpcout = (A_in & B_in) | (A_in & cin) | (B_in & cin);
wire tmpeout = (src1 ~^ src2) & ein;


always @(*) begin
	cout <= tmpcout;
	eout <= tmpeout;
	set  <= ADD;

	case(operation[2-1:0])
		0:       result <= AND;
		1:       result <= OR;
		2:       result <= ADD;
		default: result <= less;
	endcase
end

endmodule
