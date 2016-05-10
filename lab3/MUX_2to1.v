// 0317001_0310511
//Subject:     CO project 3 - MUX 221
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
     
module MUX_2to1(
	data0_i,
	data1_i,
	select_i,
	data_o
);

parameter size = 0;			   
			
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
		data_o <= data0_i;
	end
	else begin
		data_o <= data1_i;
	end
end

endmodule      
          
          
