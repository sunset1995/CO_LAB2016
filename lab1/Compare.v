//0317001_0310511
`timescale 1ns/1ps
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
	less,   //1 bit less
	equal,  //1 bit equal
	comp,   //3 bit equal
	out     //1 bit out
    );

input less;
input equal;
input [2:0]comp;

output reg out;


always @(*) begin
	if ( (less & equal) == 1'b1 )
		out <= 1'b0;
	else begin
		case(comp[2:0])
			0:       out <= less;
			1:       out <= !less & !equal;
			2:       out <= less | equal;
			3:       out <= !less;
			6:       out <= equal;
			default: out <= !equal;
		endcase
	end
end

endmodule
