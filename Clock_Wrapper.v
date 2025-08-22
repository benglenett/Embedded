`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2024 02:27:08 PM
// Design Name: 
// Module Name: Clock_Wrapper
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

module Clock_Wrapper #(parameter WIDTH = 10, MAX_COUNT_A = 639, MAX_COUNT_B = 479 )
(
    (* mark_debug = "true", keep = "true" *)
    input clk, 
    (* mark_debug = "true", keep = "true" *)
    input rst, 
    (* mark_debug = "true", keep = "true" *)
    input cen,
    (* mark_debug = "true", keep = "true" *)
    output A, 
    (* mark_debug = "true", keep = "true" *)
    output B
    );
    
    (* mark_debug = "true", keep = "true" *)
    wire B_cen;
    (* mark_debug = "true", keep = "true" *)
    wire clk_t;
    (* mark_debug = "true", keep = "true" *)
    wire locked;
    
    wire [WIDTH-1:0] A_val; 
    wire [WIDTH-1:0] B_val; 
     clk_wiz_0 instantiate_clk
   (
    // Clock out ports
    .clk_out1(clk_t),     // output clk_out1
    // Status and control signals
    .reset(rst), // input reset
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1(clk)      // input clk_in1
);
    
    binary_counter #( .MAX_COUNT(MAX_COUNT_A), .WIDTH(WIDTH)) Clk_A
    (
        .clk(clk_t),
        .rst(rst),
        .cen(cen),
        .val(A_val)
    );
    
    //enable b counter when a reaches max value, else 0;
   
       binary_counter #( .MAX_COUNT(MAX_COUNT_B), .WIDTH(WIDTH)) Clk_B
    (
        .clk(clk_t),
        .rst(rst),
        .cen(B_cen),
        .val(B_val)
    );
    
     //counter b enables only after counter a reaches max value and then turns back off
    //this will work because of the time delay from the clock edge off enabling to the clock edge of counting    
    assign B_cen = (A_val == MAX_COUNT_A) ? 1'b1 : 1'b0;
    

      //assign A = (A_val && 1'b1);
    //  assign B = (B_val && 1'b1);
    
    

    
endmodule


