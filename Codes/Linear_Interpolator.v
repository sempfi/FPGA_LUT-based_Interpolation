`timescale 1ns / 1ps

/*
	Alireza Rostami
	9832090
*/

module Linear_Interpolator (
   input [7:0] y_1,
	input [7:0] y_2,
	input [1:0] XLSB,
	output [7:0] y_linear
	);
	
	wire [9:0] product_linear_output;
	assign product_linear_output = XLSB * (y_2 - y_1);
	
	assign y_linear = y_1 + product_linear_output[9:2] + product_linear_output[1];

endmodule
