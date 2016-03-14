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


input           rst_n;
input  [32-1:0] src1;
input  [32-1:0] src2;
input   [4-1:0] ALU_control;
input   [3-1:0] bonus_control; 

output [32-1:0] result;
output          zero;
output          cout;
output          overflow;

wire Z;
wire Over;
wire [32-1:0] tmpresult;
wire set;
wire notequal;
wire equal;
wire [31:0] tmpequal;
reg    [32-1:0] result;
reg             zero;
reg             cout;
reg             overflow;

wire carry[31:0];

assign Over = carry[30] ^ carry[31];

nor nor1(Z, tmpresult[0], tmpresult[1], tmpresult[2], tmpresult[3], tmpresult[4], tmpresult[5], tmpresult[6],
				 tmpresult[7], tmpresult[8], tmpresult[9], tmpresult[10], tmpresult[11], tmpresult[12], tmpresult[13],
				  tmpresult[14], tmpresult[15], tmpresult[16], tmpresult[17], tmpresult[18], tmpresult[19], tmpresult[20],
				   tmpresult[21], tmpresult[22], tmpresult[23], tmpresult[24], tmpresult[25], tmpresult[26], tmpresult[27],
					 tmpresult[28], tmpresult[29], tmpresult[30], tmpresult[31]);

assign tmpequal[31:0] = src1[31:0] ^ src2[31:0];
or or1(notequal, tmpequal[0], tmpequal[1], tmpequal[2], tmpequal[3], tmpequal[4], tmpequal[5], tmpequal[6],
				 tmpequal[7], tmpequal[8], tmpequal[9], tmpequal[10], tmpequal[11], tmpequal[12], tmpequal[13],
				  tmpequal[14], tmpequal[15], tmpequal[16], tmpequal[17], tmpequal[18], tmpequal[19], tmpequal[20],
				   tmpequal[21], tmpequal[22], tmpequal[23], tmpequal[24], tmpequal[25], tmpequal[26], tmpequal[27],
					 tmpequal[28], tmpequal[29], tmpequal[30], tmpequal[31]);
assign equal = !notequal;

alu_top_less ALU_31(.src1(src1[31]), .src2(src2[31]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry[30]), .operation(ALU_control[1:0]), .result(tmpresult[31]), .cout(carry[31]), .set(set));
alu_top ALU_30(.src1(src1[30]), .src2(src2[30]), .less(1'b1), .equal(1'b1), .comp(bonus_control[2:0]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry[29]), .operation(ALU_control[1:0]), .result(tmpresult[30]), .cout(carry[30]));
alu_top ALU_29(.src1(src1[29]), .src2(src2[29]), .less(1'b1), .equal(1'b1), .comp(bonus_control[2:0]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry[28]), .operation(ALU_control[1:0]), .result(tmpresult[29]), .cout(carry[29]));
alu_top ALU_28(.src1(src1[28]), .src2(src2[28]), .less(1'b1), .equal(1'b1), .comp(bonus_control[2:0]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry[27]), .operation(ALU_control[1:0]), .result(tmpresult[28]), .cout(carry[28]));
alu_top ALU_27(.src1(src1[27]), .src2(src2[27]), .less(1'b1), .equal(1'b1), .comp(bonus_control[2:0]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry[26]), .operation(ALU_control[1:0]), .result(tmpresult[27]), .cout(carry[27]));
alu_top ALU_26(.src1(src1[26]), .src2(src2[26]), .less(1'b1), .equal(1'b1), .comp(bonus_control[2:0]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry[25]), .operation(ALU_control[1:0]), .result(tmpresult[26]), .cout(carry[26]));
alu_top ALU_25(.src1(src1[25]), .src2(src2[25]), .less(1'b1), .equal(1'b1), .comp(bonus_control[2:0]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry[24]), .operation(ALU_control[1:0]), .result(tmpresult[25]), .cout(carry[25]));
alu_top ALU_24(.src1(src1[24]), .src2(src2[24]), .less(1'b1), .equal(1'b1), .comp(bonus_control[2:0]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry[23]), .operation(ALU_control[1:0]), .result(tmpresult[24]), .cout(carry[24]));
alu_top ALU_23(.src1(src1[23]), .src2(src2[23]), .less(1'b1), .equal(1'b1), .comp(bonus_control[2:0]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry[22]), .operation(ALU_control[1:0]), .result(tmpresult[23]), .cout(carry[23]));
alu_top ALU_22(.src1(src1[22]), .src2(src2[22]), .less(1'b1), .equal(1'b1), .comp(bonus_control[2:0]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry[21]), .operation(ALU_control[1:0]), .result(tmpresult[22]), .cout(carry[22]));
alu_top ALU_21(.src1(src1[21]), .src2(src2[21]), .less(1'b1), .equal(1'b1), .comp(bonus_control[2:0]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry[20]), .operation(ALU_control[1:0]), .result(tmpresult[21]), .cout(carry[21]));
alu_top ALU_20(.src1(src1[20]), .src2(src2[20]), .less(1'b1), .equal(1'b1), .comp(bonus_control[2:0]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry[19]), .operation(ALU_control[1:0]), .result(tmpresult[20]), .cout(carry[20]));
alu_top ALU_19(.src1(src1[19]), .src2(src2[19]), .less(1'b1), .equal(1'b1), .comp(bonus_control[2:0]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry[18]), .operation(ALU_control[1:0]), .result(tmpresult[19]), .cout(carry[19]));
alu_top ALU_18(.src1(src1[18]), .src2(src2[18]), .less(1'b1), .equal(1'b1), .comp(bonus_control[2:0]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry[17]), .operation(ALU_control[1:0]), .result(tmpresult[18]), .cout(carry[18]));
alu_top ALU_17(.src1(src1[17]), .src2(src2[17]), .less(1'b1), .equal(1'b1), .comp(bonus_control[2:0]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry[16]), .operation(ALU_control[1:0]), .result(tmpresult[17]), .cout(carry[17]));
alu_top ALU_16(.src1(src1[16]), .src2(src2[16]), .less(1'b1), .equal(1'b1), .comp(bonus_control[2:0]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry[15]), .operation(ALU_control[1:0]), .result(tmpresult[16]), .cout(carry[16]));
alu_top ALU_15(.src1(src1[15]), .src2(src2[15]), .less(1'b1), .equal(1'b1), .comp(bonus_control[2:0]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry[14]), .operation(ALU_control[1:0]), .result(tmpresult[15]), .cout(carry[15]));
alu_top ALU_14(.src1(src1[14]), .src2(src2[14]), .less(1'b1), .equal(1'b1), .comp(bonus_control[2:0]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry[13]), .operation(ALU_control[1:0]), .result(tmpresult[14]), .cout(carry[14]));
alu_top ALU_13(.src1(src1[13]), .src2(src2[13]), .less(1'b1), .equal(1'b1), .comp(bonus_control[2:0]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry[12]), .operation(ALU_control[1:0]), .result(tmpresult[13]), .cout(carry[13]));
alu_top ALU_12(.src1(src1[12]), .src2(src2[12]), .less(1'b1), .equal(1'b1), .comp(bonus_control[2:0]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry[11]), .operation(ALU_control[1:0]), .result(tmpresult[12]), .cout(carry[12]));
alu_top ALU_11(.src1(src1[11]), .src2(src2[11]), .less(1'b1), .equal(1'b1), .comp(bonus_control[2:0]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry[10]), .operation(ALU_control[1:0]), .result(tmpresult[11]), .cout(carry[11]));
alu_top ALU_10(.src1(src1[10]), .src2(src2[10]), .less(1'b1), .equal(1'b1), .comp(bonus_control[2:0]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry[9]), .operation(ALU_control[1:0]), .result(tmpresult[10]), .cout(carry[10]));
alu_top ALU_9(.src1(src1[9]), .src2(src2[9]), .less(1'b1), .equal(1'b1), .comp(bonus_control[2:0]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry[8]), .operation(ALU_control[1:0]), .result(tmpresult[9]), .cout(carry[9]));
alu_top ALU_8(.src1(src1[8]), .src2(src2[8]), .less(1'b1), .equal(1'b1), .comp(bonus_control[2:0]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry[7]), .operation(ALU_control[1:0]), .result(tmpresult[8]), .cout(carry[8]));
alu_top ALU_7(.src1(src1[7]), .src2(src2[7]), .less(1'b1), .equal(1'b1), .comp(bonus_control[2:0]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry[6]), .operation(ALU_control[1:0]), .result(tmpresult[7]), .cout(carry[7]));
alu_top ALU_6(.src1(src1[6]), .src2(src2[6]), .less(1'b1), .equal(1'b1), .comp(bonus_control[2:0]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry[5]), .operation(ALU_control[1:0]), .result(tmpresult[6]), .cout(carry[6]));
alu_top ALU_5(.src1(src1[5]), .src2(src2[5]), .less(1'b1), .equal(1'b1), .comp(bonus_control[2:0]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry[4]), .operation(ALU_control[1:0]), .result(tmpresult[5]), .cout(carry[5]));
alu_top ALU_4(.src1(src1[4]), .src2(src2[4]), .less(1'b1), .equal(1'b1), .comp(bonus_control[2:0]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry[3]), .operation(ALU_control[1:0]), .result(tmpresult[4]), .cout(carry[4]));
alu_top ALU_3(.src1(src1[3]), .src2(src2[3]), .less(1'b1), .equal(1'b1), .comp(bonus_control[2:0]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry[2]), .operation(ALU_control[1:0]), .result(tmpresult[3]), .cout(carry[3]));
alu_top ALU_2(.src1(src1[2]), .src2(src2[2]), .less(1'b1), .equal(1'b1), .comp(bonus_control[2:0]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry[1]), .operation(ALU_control[1:0]), .result(tmpresult[2]), .cout(carry[2]));
alu_top ALU_1(.src1(src1[1]), .src2(src2[1]), .less(1'b1), .equal(1'b1), .comp(bonus_control[2:0]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(carry[0]), .operation(ALU_control[1:0]), .result(tmpresult[1]), .cout(carry[1]));
alu_top ALU_0(.src1(src1[0]), .src2(src2[0]), .less(set), .equal(equal), .comp(bonus_control[2:0]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_control[2]), .operation(ALU_control[1:0]), .result(tmpresult[0]), .cout(carry[0]));


always@(*)
begin
	if( rst_n == 0 )
		begin
			result <= 0;
			zero <= 0;
			cout <= 0;
			overflow <= 0;
		end
	else
		begin
			result[32-1:0] <= tmpresult[32-1:0];
			zero <= Z;
			cout <= carry[31];
			overflow <= Over;
		end
end

endmodule
