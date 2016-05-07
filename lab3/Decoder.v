// 0317001_0310511
//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Decoder(
    instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o
);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
 
//Internal Signals
wire           RegWrite_o;
wire   [3-1:0] ALU_op_o;
wire           ALUSrc_o;
wire           RegDst_o;
wire           Branch_o;

wire rtype;
wire beq;
wire bne;
wire addi;
wire sltiu;
wire ori;
wire lui;


assign rtype = (instr_op_i==0);
assign beq   = (instr_op_i==4);
assign bne   = (instr_op_i==5);
assign addi  = (instr_op_i==8);
assign sltiu = (instr_op_i==9);
assign ori   = (instr_op_i==13);
assign lui   = (instr_op_i==15);

assign RegWrite_o = (rtype | addi | sltiu | ori | lui);
assign ALUSrc_o   = (addi | sltiu | ori | lui);
assign RegDst_o   = rtype;
assign Branch_o   = (beq | bne);

assign ALU_op_o[2] = (beq | sltiu | lui);
assign ALU_op_o[1] = (beq | bne | addi | sltiu);
assign ALU_op_o[0] = (bne | sltiu | ori);

endmodule
