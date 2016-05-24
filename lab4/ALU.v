// 0317001_0310511
//Subject:     CO project 3 - ALU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU(
    src1_i,
	src2_i,
	ctrl_i,
	result_o,
	zero_o
);
     
//I/O ports
input  [32-1:0]  src1_i;
input  [32-1:0]	 src2_i;
input  [4-1:0]   ctrl_i;

output [32-1:0]	 result_o;
output           zero_o;

//Internal signals
reg    [32-1:0]  result_o;
wire             zero_o;

assign zero_o = (result_o==0);

//Main function
always @(*) begin
	case(ctrl_i[3:0])
		4'b0000: result_o <= src1_i & src2_i;
		4'b0001: result_o <= src1_i | src2_i;
		4'b0010: result_o <= src1_i + src2_i;
		4'b0011: begin
			if( (src1_i ^ src2_i) ) begin
				result_o <= 0;
			end
			else begin
				result_o <= 1;
			end
		end 
		4'b0100: // LUI
			result_o <= (src2_i<<16);
		4'b0101: result_o <= src1_i * src2_i;
		4'b0110: result_o <= src1_i - src2_i;
		4'b0111: begin // slt
				 	if( $signed(src1_i)<$signed(src2_i) ) begin
				 		result_o <= 1;
				 	end
				 	else begin
				 		result_o <= 0;
				 	end
				 end
		4'b1111: begin // set greater than
				 	if ( $signed(src1_i)>$signed(src2_i) ) begin
				 		result_o <= 1;
				 	end
				 	else begin
				 		result_o <= 0;
				 	end
		end
		4'b1001: begin // set greater equal than
				 	if ( $signed(src1_i)>=$signed(src2_i) ) begin
				 		result_o <= 1;
				 	end
				 	else begin
				 		result_o <= 0;
				 	end
		end
		default: // SRA(1000), SRAV(1000)
			result_o <= $signed(src2_i)>>>src1_i;
	endcase
end

endmodule





                    
                    
