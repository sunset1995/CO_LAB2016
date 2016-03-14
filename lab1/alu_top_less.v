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
               operation,  //operation      (input)
               result,     //1 bit result   (output)
               cout,       //1 bit carry out(output)
               set //set output
               );

input         src1;
input         src2;
input         less;
input         A_invert;
input         B_invert;
input         cin;
input [2-1:0] operation;

output        result;
output        cout;
output 		  set;
wire AND;
wire OR;
wire ADD;

reg           result;
reg cout;
reg set;
wire A_in = src1^A_invert;
wire B_in = src2^B_invert;
wire couttmp;
assign AND =  A_in & B_in;
assign OR = A_in | B_in;
assign ADD = cin ^ src1 ^ B_in;
assign couttmp = (A_in & B_in) | (cin & B_in) | (cin & A_in);

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
		result <= less;
		set <= ADD;
		cout <= couttmp;
	end

end

endmodule
