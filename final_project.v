`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:53:42 01/05/2017 
// Design Name: 
// Module Name:    final_project 
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
module final_project(
	input clk,
	input reset,
	output signed [7:0] reg1,
	output signed [7:0] reg2,
	output signed [7:0] reg3,
	output signed [7:0] reg4,
	output              zeroflag,
	output              overflow
	);


wire [19:0] instruction;

// Wire for decoder output
wire        writeBack;
wire        selectConst;
wire [2:0]  alu_op;

// Wire for registers output
wire [7:0]  data1;
wire [7:0]  data2_tmp;
wire [7:0]  data2         = (selectConst ? instruction[7:0] : data2_tmp);

// Wire for alu output
wire [7:0]  writeBackData;
wire        overflow;
wire        zeroflag;


pc_instruction pc_instruction(
	.clk(clk),
	.hold(1'b0),
	.reset(reset),
	.instruction(instruction));

data_memory data_memory(
	.reset(reset),
	.clk(clk),
	.select1(instruction[15:8]),
	.select2(instruction[7:0]),
	.writeBack(writeBack),
	.writeBackData(writeBackData),
	.out1(data1),
	.out2(data2_tmp),
	.reg1(reg1),
	.reg2(reg2),
	.reg3(reg3),
	.reg4(reg4)
	);

decoder decoder(
	.opcode(instruction[19:16]),
	.writeBack(writeBack),
	.selectConst(selectConst),
	.alu_op(alu_op)
	);

alu alu(
	.alu_op(alu_op),
	.data1(data1),
	.data2(data2),
	.ans(writeBackData),
	.overflow(overflow),
	.zeroflag(zeroflag)
	);


endmodule
