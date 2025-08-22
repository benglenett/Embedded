`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2024 02:23:15 PM
// Design Name: 
// Module Name: binary_counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module binary_counter #(parameter MAX_COUNT = 255, WIDTH = 8)(

  	input rst, clk, cen,
	output reg [WIDTH-1:0] val
);
    initial val = 1'b0;
    
    always @(posedge clk or posedge rst) begin
		if (rst) 
			val <= 0;  // Reset the counter to zero
		else if (cen) begin
			if (val == MAX_COUNT)
				val <= 1'b0;  // Reset to zero if max count is reached
			else
				val <= val + 1'b1;  // Increment the counter
		end
	end
endmodule
