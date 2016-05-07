// 0317001_0310511
//Subject:     CO project 2 - ALU Controller
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU_Ctrl(
	funct_i,
	ALUOp_i,
	ALUCtrl_o
);
          
//I/O ports 
input  [6-1:0] funct_i;
input  [3-1:0] ALUOp_i;

output [4-1:0] ALUCtrl_o;    
     
//Internal Signals
reg    [4-1:0] ALUCtrl_o;

//Select exact operation
always @(*) begin
	case(funct_i)
		 3: ALUCtrl_o <= 4'b1000;
		 7: ALUCtrl_o <= 4'b1000;
		24: ALUCtrl_o <= 4'b0101;
		32: ALUCtrl_o <= 4'b0010;
		34: ALUCtrl_o <= 4'b0110;
		36: ALUCtrl_o <= 4'b0000;
		37: ALUCtrl_o <= 4'b0001;
		42: ALUCtrl_o <= 4'b0111;
		default: begin
			ALUCtrl_o[3]   <= (ALUOp_i==1 || ALUOp_i==7);
			ALUCtrl_o[2:0] <= ALUOp_i[2:0];
		end
	endcase
end

endmodule     





                    
                    
