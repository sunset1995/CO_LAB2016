// 0317001_0310511
//Subject:     CO project 4 - Decoder
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
    Branch_o,
    Jump_o,
    MemRead_o,
    MemWrite_o,
    MemtoReg_o,
    Jal_o
);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
output         Jump_o;
output         MemRead_o;
output         MemWrite_o;
output         MemtoReg_o;
output         Jal_o;
 
//Internal Signals
wire           RegWrite_o;
wire   [3-1:0] ALU_op_o;
wire           ALUSrc_o;
wire           RegDst_o;
wire           Branch_o;
wire           Jump_o;
wire           MemRead_o;
wire           MemWrite_o;
wire           MemtoReg_o;
wire           Jal_o;

wire rtype;
wire blt;
wire beq;
wire bne;
wire ble;
wire addi;
wire sltiu;
wire ori;
wire lui;
wire jump;    // 000010
wire lw;      // 100011
wire sw;      // 101011
wire jal;     // 000011


assign rtype = (instr_op_i==0);
assign blt   = (instr_op_i==1);
assign beq   = (instr_op_i==4);
assign bne   = (instr_op_i==5);
assign ble   = (instr_op_i==6);
assign addi  = (instr_op_i==8);
assign sltiu = (instr_op_i==9);
assign ori   = (instr_op_i==13);
assign lui   = (instr_op_i==15);
assign jump  = (instr_op_i==2);
assign lw    = (instr_op_i==35);
assign sw    = (instr_op_i==43);
assign jal   = (instr_op_i==3);

assign RegWrite_o = (rtype | addi | sltiu | ori | lui | lw | jal);
assign ALUSrc_o   = (addi | sltiu | ori | lui | lw | sw);
assign RegDst_o   = rtype;
assign Branch_o   = (blt | beq | bne | ble);
assign Jump_o     = (jump | jal);
assign MemRead_o  = lw;
assign MemWrite_o = sw;
assign MemtoReg_o = lw;
assign Jal_o      = jal;

assign ALU_op_o[2] = (beq | ble | sltiu | lui);
assign ALU_op_o[1] = (beq | ble | bne | addi | sltiu | lw | sw);
assign ALU_op_o[0] = (blt | bne | ble | sltiu | ori);

endmodule
