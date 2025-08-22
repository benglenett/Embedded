`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 01:56:35 PM
// Design Name: 
// Module Name: rgb
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


//module rgb(
//    input wire [31:0] clk_div_value,
//    output reg [2:0] RGB_out
//);
//    always @(*) begin
//        if (clk_div_value == 32'd100000) // 1kHz frequency
//            RGB_out = 3'b111;
//        else if (clk_div_value > 32'd100000) // Frequency below 1kHz
//            RGB_out = 3'b001;           
//        else                             // Frequency above 1kHz
//            RGB_out = 3'b010;
//    end
//endmodule