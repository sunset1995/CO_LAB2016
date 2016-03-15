//0317001_0310511
`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    15:15:11 02/25/2016
// Design Name:
// Module Name:    alu
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

module alu(
	rst_n,         // negative reset            (input)
	src1,          // 32 bits source 1          (input)
	src2,          // 32 bits source 2          (input)
	ALU_control,   // 4 bits ALU control input  (input)
	bonus_control, // 3 bits bonus control input(input) 
	result,        // 32 bits result            (output)
	zero,          // 1 bit when the output is 0, zero must be set (output)
	cout,          // 1 bit carry out           (output)
	overflow       // 1 bit overflow            (output)
	);

input rst_n;
input [32-1:0] src1;
input [32-1:0] src2;
input [ 4-1:0] ALU_control;
input [ 3-1:0] bonus_control; 

output reg [32-1:0] result;
output reg zero;
output reg cout;
output reg overflow;

wire [32-1:0] carry;
wire [32-1:0] tmpresult;
wire [32-1:0] tmpeout;
wire Z;
wire Over;
wire set;

assign Z    = ~|tmpresult;
assign Over = carry[30] ^ carry[31];

alu_top_less ALU_31(.src1(src1[31]), .src2(src2[31]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry[30]), .ein(tmpeout[30]), .operation(ALU_control[1:0]), .result(tmpresult[31]), .cout(carry[31]), .eout(tmpeout[31]), .set(set));
generate
	genvar i;
	for (i=1; i<31; i=i+1) begin:ALU_
		alu_top ALU_tachi(
			.src1(src1[i]),
			.src2(src2[i]),
			.less(1'b1),
			.equal(1'b1),
			.comp(bonus_control[2:0]),
			.A_invert(ALU_control[3]),
			.B_invert(ALU_control[2]),
			.cin(carry[i-1]),
			.ein(tmpeout[i-1]),
			.operation(ALU_control[1:0]),
			.result(tmpresult[i]),
			.cout(carry[i]),
			.eout(tmpeout[i])
		);
	end
endgenerate
alu_top ALU_0(.src1(src1[0]), .src2(src2[0]), .less(set), .equal(tmpeout[31]), .comp(bonus_control[2:0]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_control[2]), .ein(1'b1), .operation(ALU_control[1:0]), .result(tmpresult[0]), .cout(carry[0]), .eout(tmpeout[0]));


always @(*) begin
	if( rst_n == 0 ) begin
		result   <= 0;
		zero     <= 0;
		cout     <= 0;
		overflow <= 0;
	end
	else begin
		result   <= tmpresult;
		zero     <= Z;
		cout     <= carry[31];
		overflow <= Over;
	end
end

endmodule
