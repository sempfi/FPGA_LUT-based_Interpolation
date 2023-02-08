`timescale 1ns / 1ps

/*
	Alireza Rostami
	9832090
*/

module Main (
	input clk, 
	input  [7:0] x_input, 
	output [7:0] y_output_linear,
	output [7:0] y_output_quadratic,
	output [7:0] y_output_exact
	);
	
	integer i;
	reg [7:0] ROM [0:255];
	reg [7:0] ROM_64 [0:63];
	
	// Initiating the 256-slots ROM. 
	initial begin
		 $readmemb("ROM.bin", ROM);
	end
		
	// Initiating the 64-slots ROM. 
	initial begin
		for (i = 0; i < 64; i = i + 1) begin
			ROM_64[i] <= ROM[i*4];
		end
	end
	
	reg [7:0] y_1;
	reg [7:0] y_2;
	reg [7:0] y_3;

	wire [5:0] XMSB;
	wire [1:0] XLSB;
	assign XMSB = x_input[7:2];
	assign XLSB = x_input[1:0];
	
	always @(posedge clk) begin
		y_1 <= ROM_64[XMSB+0];
		y_2 <= ROM_64[XMSB+1];
		y_3 <= ROM_64[XMSB+2];
	end
	
	// Linear interpolation
	Linear_Interpolator LinearInterpolator (
		.y_1(y_1), 
		.y_2(y_2), 
		.XLSB(XLSB), 
		.y_linear(y_output_linear)
   );
	
	// Quadratic interpolation
	Quadratic_Interpolator QuadraticInterpolator (
		.y_1(y_1), 
		.y_2(y_2), 
		.y_3(y_3), 
		.XLSB(XLSB), 
		.y_quadratic(y_output_quadratic)
   );
	
	assign y_output_exact = ROM[x_input];


endmodule
