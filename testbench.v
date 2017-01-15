`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:46:44 01/14/2017
// Design Name:   final_project
// Module Name:   C:/Users/user/Desktop/sunset/testbench.v
// Project Name:  final_project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: final_project
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testbench;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire [7:0] reg1;
	wire [7:0] reg2;
	wire [7:0] reg3;
	wire [7:0] reg4;

	// Instantiate the Unit Under Test (UUT)
	final_project uut (
		.clk(clk), 
		.reset(reset), 
		.reg1(reg1), 
		.reg2(reg2), 
		.reg3(reg3), 
		.reg4(reg4)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		reset = 0;

	end
	
	always #5 clk = ~clk;
      
endmodule

