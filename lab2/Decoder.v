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
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg            Branch_o;

//Main function
always @(*) begin
	case(instr_op_i) begin
		4: begin
			RegWrite_o <= 1;
			ALU_op_o   <= 5;
			ALUSrc_o   <= 0;
			Branch_o   <= 1;
		end
		8: begin
			RegWrite_o <= 1;
			ALU_op_o   <= 2;
			ALUSrc_o   <= 1;
			RegDst_o   <= 0;
			Branch_o   <= 0;
		end
		9: begin
			RegWrite_o <= 1;
			ALU_op_o   <= 7;
			ALUSrc_o   <= 1;
			RegDst_o   <= 0;
			Branch_o   <= 0;
		end
		default: begin
			RegWrite_o <= 1;
			ALUSrc_o   <= 0;
			RegDst_o   <= 1;
			Branch_o   <= 0;
		end
	end
end

endmodule





                    
                    
