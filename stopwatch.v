`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 02:52:41 PM
// Design Name: 
// Module Name: stopwatch
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


//module stopwatch(
//    input wire clk, 
//    input wire reset,  
//    input wire start_stop,
//    output reg [15:0] seconds
//);
//     reg running = 0; 
//     wire enable;
//    // Start/Stop control
//    always @(posedge clk or posedge reset) begin
//        if (reset) begin
//            running <= 0;
//        end else if (start_stop) begin
//            running <= ~running;
//        end
//    end

//    // Stopwatch counting logic
//    always @(posedge clk or posedge reset) begin
//        if (reset) begin
//            seconds <= 0;
//        end else if (enable && running) begin
//            if (seconds == 9999) begin
//                seconds <= 0;
//            end else begin
//                seconds <= seconds + 1;
//            end
//        end
//    end
//endmodule