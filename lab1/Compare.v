//0317001_0310511
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:38:03 03/14/2016 
// Design Name: 
// Module Name:    Compare 
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
module Compare(
		less,	//1 bit less
		equal,	//1 bit equal
		comp,	//3 bit equal
		out	//1 bit out
    );

input less;
input equal;
input [2:0]comp;

output out;
reg out;

wire zero = less & equal;

always @(*) begin
	if ( zero == 1 )
		begin
			out = 1'b0;
		end
	else
		begin
				
			if( comp == 0)
				begin
					out = less;
				end

			else if( comp == 1)
				begin
					out = !less & !equal;
				end

			else if( comp == 2)
				begin
					out = less | equal;
				end

			else if ( comp == 3)
				begin
					out = !less;
				end

			else if ( comp == 6)
				begin
					out = equal;
				end
				
			else
				begin
					out = !equal;
				end
			
		end
end

endmodule
