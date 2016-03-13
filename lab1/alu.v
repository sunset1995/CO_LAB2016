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
		 //bonus_control, // 3 bits bonus control input(input) 
           result,        // 32 bits result            (output)
           zero,          // 1 bit when the output is 0, zero must be set (output)
           cout,          // 1 bit carry out           (output)
           overflow       // 1 bit overflow            (output)
           );


input           rst_n;
input  [32-1:0] src1;
input  [32-1:0] src2;
input   [4-1:0] ALU_control;
//input   [3-1:0] bonus_control; 

output [32-1:0] result;
output          zero;
output          cout;
output          overflow;
 
reg    [32-1:0] result;
reg             zero;
reg             cout;
reg             overflow;

nor ZERO(zero, result[0], result[1], result[2], result[3], result[4], result[5], result[6],
				 result[7], result[8], result[9], result[10], result[11], result[12], result[13],
				  result[14], result[15], result[16], result[17], result[18], result[19], result[20],
				   result[21], result[22], result[23], result[24], result[25], result[26], result[27],
					 result[28], result[29], result[30], result[31]);

xor OVERFLOW(overflow, ALU_30.cout, ALU_31.cout);


alu_top ALU_31(.src1(src1[31]), .src2(src2[31]), .less(ALU_control[3]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_30.cout), .operation(ALU_control[1:0]), .result(result[31]), .cout(cout));
alu_top ALU_30(.src1(src1[30]), .src2(src2[30]), .less(ALU_control[3]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_29.cout), .operation(ALU_control[1:0]), .result(result[30]), .cout(ALU_31.cin));
alu_top ALU_29(.src1(src1[29]), .src2(src2[29]), .less(ALU_control[3]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_28.cout), .operation(ALU_control[1:0]), .result(result[29]), .cout(ALU_30.cin));
alu_top ALU_28(.src1(src1[28]), .src2(src2[28]), .less(ALU_control[3]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_27.cout), .operation(ALU_control[1:0]), .result(result[28]), .cout(ALU_29.cin));
alu_top ALU_27(.src1(src1[27]), .src2(src2[27]), .less(ALU_control[3]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_26.cout), .operation(ALU_control[1:0]), .result(result[27]), .cout(ALU_28.cin));
alu_top ALU_26(.src1(src1[26]), .src2(src2[26]), .less(ALU_control[3]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_25.cout), .operation(ALU_control[1:0]), .result(result[26]), .cout(ALU_27.cin));
alu_top ALU_25(.src1(src1[25]), .src2(src2[25]), .less(ALU_control[3]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_24.cout), .operation(ALU_control[1:0]), .result(result[25]), .cout(ALU_26.cin));
alu_top ALU_24(.src1(src1[24]), .src2(src2[24]), .less(ALU_control[3]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_23.cout), .operation(ALU_control[1:0]), .result(result[24]), .cout(ALU_25.cin));
alu_top ALU_23(.src1(src1[23]), .src2(src2[23]), .less(ALU_control[3]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_22.cout), .operation(ALU_control[1:0]), .result(result[23]), .cout(ALU_24.cin));
alu_top ALU_22(.src1(src1[22]), .src2(src2[22]), .less(ALU_control[3]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_21.cout), .operation(ALU_control[1:0]), .result(result[22]), .cout(ALU_23.cin));
alu_top ALU_21(.src1(src1[21]), .src2(src2[21]), .less(ALU_control[3]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_20.cout), .operation(ALU_control[1:0]), .result(result[21]), .cout(ALU_22.cin));
alu_top ALU_20(.src1(src1[20]), .src2(src2[20]), .less(ALU_control[3]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_19.cout), .operation(ALU_control[1:0]), .result(result[20]), .cout(ALU_21.cin));
alu_top ALU_19(.src1(src1[19]), .src2(src2[19]), .less(ALU_control[3]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_18.cout), .operation(ALU_control[1:0]), .result(result[19]), .cout(ALU_20.cin));
alu_top ALU_18(.src1(src1[18]), .src2(src2[18]), .less(ALU_control[3]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_17.cout), .operation(ALU_control[1:0]), .result(result[18]), .cout(ALU_19.cin));
alu_top ALU_17(.src1(src1[17]), .src2(src2[17]), .less(ALU_control[3]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_16.cout), .operation(ALU_control[1:0]), .result(result[17]), .cout(ALU_18.cin));
alu_top ALU_16(.src1(src1[16]), .src2(src2[16]), .less(ALU_control[3]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_15.cout), .operation(ALU_control[1:0]), .result(result[16]), .cout(ALU_17.cin));
alu_top ALU_15(.src1(src1[15]), .src2(src2[15]), .less(ALU_control[3]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_14.cout), .operation(ALU_control[1:0]), .result(result[15]), .cout(ALU_16.cin));
alu_top ALU_14(.src1(src1[14]), .src2(src2[14]), .less(ALU_control[3]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_13.cout), .operation(ALU_control[1:0]), .result(result[14]), .cout(ALU_15.cin));
alu_top ALU_13(.src1(src1[13]), .src2(src2[13]), .less(ALU_control[3]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_12.cout), .operation(ALU_control[1:0]), .result(result[13]), .cout(ALU_14.cin));
alu_top ALU_12(.src1(src1[12]), .src2(src2[12]), .less(ALU_control[3]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_11.cout), .operation(ALU_control[1:0]), .result(result[12]), .cout(ALU_13.cin));
alu_top ALU_11(.src1(src1[11]), .src2(src2[11]), .less(ALU_control[3]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_10.cout), .operation(ALU_control[1:0]), .result(result[11]), .cout(ALU_12.cin));
alu_top ALU_10(.src1(src1[10]), .src2(src2[10]), .less(ALU_control[3]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_9.cout), .operation(ALU_control[1:0]), .result(result[10]), .cout(ALU_11.cin));
alu_top ALU_9(.src1(src1[9]), .src2(src2[9]), .less(ALU_control[3]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_8.cout), .operation(ALU_control[1:0]), .result(result[9]), .cout(ALU_10.cin));
alu_top ALU_8(.src1(src1[8]), .src2(src2[8]), .less(ALU_control[3]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_7.cout), .operation(ALU_control[1:0]), .result(result[8]), .cout(ALU_9.cin));
alu_top ALU_7(.src1(src1[7]), .src2(src2[7]), .less(ALU_control[3]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_6.cout), .operation(ALU_control[1:0]), .result(result[7]), .cout(ALU_8.cin));
alu_top ALU_6(.src1(src1[6]), .src2(src2[6]), .less(ALU_control[3]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_5.cout), .operation(ALU_control[1:0]), .result(result[6]), .cout(ALU_7.cin));
alu_top ALU_5(.src1(src1[5]), .src2(src2[5]), .less(ALU_control[3]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_4.cout), .operation(ALU_control[1:0]), .result(result[5]), .cout(ALU_6.cin));
alu_top ALU_4(.src1(src1[4]), .src2(src2[4]), .less(ALU_control[3]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_3.cout), .operation(ALU_control[1:0]), .result(result[4]), .cout(ALU_5.cin));
alu_top ALU_3(.src1(src1[3]), .src2(src2[3]), .less(ALU_control[3]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_2.cout), .operation(ALU_control[1:0]), .result(result[3]), .cout(ALU_4.cin));
alu_top ALU_2(.src1(src1[2]), .src2(src2[2]), .less(ALU_control[3]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_1.cout), .operation(ALU_control[1:0]), .result(result[2]), .cout(ALU_3.cin));
alu_top ALU_1(.src1(src1[1]), .src2(src2[1]), .less(ALU_control[3]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_0.cout), .operation(ALU_control[1:0]), .result(result[1]), .cout(ALU_2.cin));
alu_top ALU_0(.src1(src1[0]), .src2(src2[0]), .less(result[31]), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_control[2]), .operation(ALU_control[1:0]), .result(result[0]), .cout(ALU_1.cin));



always@(*)
begin
	if( rst_n == 1);
	begin
		result <= 0;
		zero <= 0;
		cout <= 0;
		overflow <= 0;
	end
end

endmodule
