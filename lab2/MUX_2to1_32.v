//Subject:     CO project 2 - MUX 221
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
     
module MUX_2to1_32(
               data0_i,
               data1_i,
               select_i,
               data_o
               );

parameter size = 32;			   
			
//I/O ports               
input   [size-1:0] data0_i;          
input   [size-1:0] data1_i;
input              select_i;
output  [size-1:0] data_o; 

//Internal Signals
reg     [size-1:0] data_o;

//Main function
always @(*) begin
	if (select_i==0) begin	
		data_o = data0_i;
	end
	else
		data_o = data1_i;
	end
end

endmodule      
          
          