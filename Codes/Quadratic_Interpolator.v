`timescale 1ns / 1ps

/*
	Alireza Rostami
	9832090
*/

module Quadratic_Interpolator (
   input [7:0] y_1,
	input [7:0] y_2,
	input [7:0] y_3,
	input [1:0] XLSB,
	output [7:0] y_quadratic
	);
	
	wire [7:0] y_output_linear;
	Linear_Interpolator LinearInterpolator (
		.y_1(y_1), 
		.y_2(y_2), 
		.XLSB(XLSB), 
		.y_linear(y_output_linear)
   );
	
	wire [7:0] x_bar;
	wire [7:0] y_bar;
	wire [17:0] product_quadratic_output;
	assign x_bar = {6'b111111, XLSB};
	assign y_bar = y_3 - 2 * y_2 + y_1;
	assign product_quadratic_output = (x_bar * XLSB * y_bar) >> 5;
	
	assign y_quadratic = y_output_linear + product_quadratic_output[17:10];

endmodule
