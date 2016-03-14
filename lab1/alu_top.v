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

module alu_top(
		src1,       //1 bit source 1 (input)
		src2,       //1 bit source 2 (input)
		less,       //1 bit less     (input)
		equal,		//1 bit equal    (input)
		comp,	//3 bit equal
		A_invert,   //1 bit A_invert (input)
		B_invert,   //1 bit B_invert (input)
		cin,        //1 bit carry in (input)
		operation,  //operation      (input)
		result,     //1 bit result   (output)
		cout       //1 bit carry out(output)
		);

input         src1;
input         src2;
input         less;
input         equal;
input [2:0]   comp;
input         A_invert;
input         B_invert;
input         cin;
input [2-1:0] operation;

output        result;
output        cout;

wire AND;
wire OR;
wire ADD;

reg result;
reg cout;
wire A_in = src1^A_invert;
wire B_in = src2^B_invert;
wire couttmp;
wire tmpcomp;
assign AND =  A_in & B_in;
assign OR = A_in | B_in;
assign ADD = cin ^ src1 ^ B_in;
assign couttmp = (A_in & B_in) | (cin & B_in) | (cin & A_in);
Compare cmp(.less(less), .equal(equal), .comp(comp[2:0]), .out(tmpcomp));

always@( * )
begin

	if( operation == 0)
		begin
			result <= AND;
			cout <= 0;
		end

	else if( operation == 1)
		begin
			result <= OR;
			cout <= 0;
		end

	else if( operation == 2)
		begin
			result <= ADD;
			cout <= couttmp;
		end
		
	else
		begin
			result <= tmpcomp;
			cout <= couttmp;
		end

end

endmodule
