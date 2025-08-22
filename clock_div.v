`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 01:45:16 PM
// Design Name: 
// Module Name: clock_div
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


//module clock_div(
//    input wire clk,
//    input wire reset,
//    input wire double, 
//    input wire halve,
//    output wire clk_out,
//    output wire [31:0] clk_div_value
//);
//    reg [31:0] clk_div = 32'd100000; // Start at 1ms (1kHz frequency)
//    reg [31:0] counter = 32'd0;
//    reg clk_out_reg = 0;
    
//    always @(posedge clk or posedge reset) begin
//        if (reset) begin
//            clk_div <= 32'd100000; // Reset to 1khz
//            counter <= 32'd0;
//            clk_out_reg <= 0;
//        end else begin
//            if (double)
//                clk_div <= clk_div >> 1; //divide by 2
//            else if (halve)
//                clk_div <= clk_div << 1; // multiply by 2

//            // Clock division
//            if (counter >= clk_div) begin
//                counter <= 32'd0;
//                clk_out_reg <= ~clk_out_reg;
//            end else begin
//                counter <= counter + 1;
//            end
//        end
//    end
    
//    assign clk_out = clk_out_reg;
//endmodule