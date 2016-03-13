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
input         A_invert;
input         B_invert;
input         cin;
input [2-1:0] operation;

output        result;
output        cout;

wire AND;
wire OR;
wire ADD;

reg           result;

and AND_gate(AND, src1^A_invert, src2^B_invert);
or OR_gate(OR, src1^A_invert, src2^B_invert);
xor(ADD, cin, A, B);
assign cout = (A && B) | (cin && B) | (cin && A);

// ^ is XOR operator, && is AND operator

always@( * )
begin

if( operation == 0)
	begin
		result <= AND;
	end

else if( operation == 1)
	begin
		result <= OR;
	end

else if( operation == 2)
	begin
		result <= ADD;
	end
	
else
	begin
		result <= less;
	end

end
endmodule
