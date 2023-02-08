`timescale 1ns / 1ps

module Main___TEST;

	// Inputs
	reg clk;
	reg [7:0] x_input;

	// Outputs
	wire [7:0] y_output_linear;
	wire [7:0] y_output_quadratic;
	wire [7:0] y_output_exact;

	// Instantiate the Unit Under Test (UUT)
	Main uut (
		.clk(clk), 
		.x_input(x_input), 
		.y_output_linear(y_output_linear), 
		.y_output_quadratic(y_output_quadratic), 
		.y_output_exact(y_output_exact)
	);
	
	always #50 clk = ~clk;
	always #100 x_input = x_input + 1;
	initial begin
		clk = 0;
		x_input = 8'd180;
	end
      
endmodule

