`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 01:44:52 PM
// Design Name: 
// Module Name: wrapper
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


module wrapper(
    input clk,
    input [3:0] btn,
    output [3:0] seg_an,
    output [7:0] seg_cat,
    output [3:0] rgb_led_A
    );
    
    wire clk_divided;           // Clock output from ClockDivider
    wire [31:0] clk_div_value;  // Current clock divider value (for RGB control)
    
    reg [3:0] digit_in;
    reg [1:0] digit_sel;
    wire [15:0] count;
   
    clock_div clock_divider_inst (
        .clk(clk),
        .reset(btn[3]),
        .double(btn[1]),
        .halve(btn[0]),
        .clk_out(clk_divided),
        .clk_div_value(clk_div_value)
    );

 
    FourDigitCounter counter1 (
        .clk(clk_divided), 
        .reset(btn[3]),
        .count_out(count)
    );
    
    rgb rgb_inst (
        .clk_div_value(clk_div_value), 
        .RGB_out(RGB_led_A)
    );
    
    always @(posedge clk or posedge btn[3]) begin
        if (btn[3]) begin
            digit_sel <= 2'b00;
            digit_in <= 4'b0000;
            end
        else if(digit_sel ==2'b00) begin
            digit_sel <= digit_sel + 1;
            digit_in <= count[7:4];
            end
        else if(digit_sel == 2'b01) begin
            digit_sel <= digit_sel + 1;
            digit_in <= count[11:8];
            end
        else if(digit_sel == 2'b10) begin
            digit_sel <= digit_sel + 1;
            digit_in <= count[15:14];
            end
        else begin
        digit_sel <= 2'b00;
        digit_in <= count[3:0];
        end
    end
    
    SevenSegment seven_segment_block1 (
        .digit_in(digit_in), 
        .digit_select(digit_sel),
        .segments(seg_cat),
        .anodes(seg_an) 
    );
    
    
    /*
    
    
    FourDigitCounter counter1 (
        .clk(clk_divided), 
        .reset(btn[3]),
        .count_out(count)
    );
    
    stopwatch(
    .clk(clk_divided),
    .reset(btn[3]), 
    .start_stop(btn[0]),
    .minutes(),
    .seconds,
    .tenths
);


    always @(posedge clk or posedge btn[3]) begin
        if (btn[3]) begin
            digit_sel <= 2'b00;
            digit_in <= 4'b0000;
            end
        else if(digit_sel ==2'b00) begin
            digit_sel <= digit_sel + 1;
            digit_in <= count[7:4];
            end
        else if(digit_sel == 2'b01) begin
            digit_sel <= digit_sel + 1;
            digit_in <= count[11:8];
            end
        else if(digit_sel == 2'b10) begin
            digit_sel <= digit_sel + 1;
            digit_in <= count[15:14];
            end
        else begin
        digit_sel <= 2'b00;
        digit_in <= count[3:0];
        end
    end
    
    SevenSegment seven_segment_block1 (
        .digit_in(digit_in), 
        .digit_select(digit_sel),
        .segments(seg_cat),
        .anodes(seg_an) 
    );
    
    */
    
    
endmodule
