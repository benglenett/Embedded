`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/16/2024 01:57:34 PM
// Design Name: 
// Module Name: VGA_Sync_generator
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
    // master clk
    input clk,
    input rst,
    input [7:0] sw,
    input [2:0] btn,
    // VGA output ports
    output vga_hsync,
    output vga_vsync,
    output [3:0] vga_red,
    output [3:0] vga_green,
    output [3:0] vga_blue,
    // hdmi output ports
    output  hdmi_tx_hpd,
    output TMDS_CLK_P,
    output TMDS_CLK_N,
    output  [2:0] TMDS_DATA_P,
    output  [2:0] TMDS_DATA_N
);
    
    wire pix_clk;
    wire pix_clkx5;
    
    wire locked;
    wire pix_rst;
        
    wire hsync;
    wire vsync;
    wire vde;
    reg [3:0] red;
    reg [3:0] green;
    reg [3:0] blue;
    reg [7:0] x_dir;
    reg [7:0] y_dir;
    clk_wiz_1 clk_wiz_inst
    (
    // Clock out ports  
    .clk(pix_clk),
    .clk_x5(pix_clkx5),
    // Status and control signals               
    .reset(rst), 
    .locked(locked),
   // Clock in ports
    .clk_in(clk)
    );
    
    assign pix_rst = rst | ~locked;
    
    hdmi_tx_v1_0 # (
        .C_RED_WIDTH(4),
        .C_GREEN_WIDTH(4),
        .C_BLUE_WIDTH(4),
        .MODE("HDMI")
    ) hdmi_tx_inst (
        .pix_clk(pix_clk),
        .pix_clkx5(pix_clkx5),
        .pix_clk_locked(locked),
        .rst(rst),
        .red(red),
        .green(green),
        .blue(blue),
        .hsync(hsync),
        .vsync(vsync),
        .vde(vde),
        .aux0_din(4'h0),
        .aux1_din(4'h0),
        .aux2_din(4'h0),
        .ade(1'h0),
        .TMDS_CLK_P(TMDS_CLK_P),
        .TMDS_CLK_N(TMDS_CLK_N),
        .TMDS_DATA_P(TMDS_DATA_P),
        .TMDS_DATA_N(TMDS_DATA_N)
    );

    localparam hs_end = 96;
    localparam hbp_end = 48;
    localparam hfp_begin = 16;
    localparam hline_end = 800;
    localparam vs_end = 2;
    localparam vbp_end = 33;
    localparam vfp_begin = 10;
    localparam vline_end = 525;
    
    localparam box_x = 300;
    localparam box_y = 240;

    reg [11:0] hcount = 12'h0;
    reg [11:0] vcount = 12'h0;

    always @(posedge pix_clk)
    begin
        if (pix_rst == 1'b1)
        begin
            hcount <= 12'h0;
            vcount <= 12'h0;
        end
        else
        begin
            if (hcount == hline_end - 1)
            begin
                hcount <= 12'h0;
                if (vcount == vline_end - 1)
                    vcount <= 12'h0;
                else
                    vcount <= vcount + 1'b1;
            end
            else
            begin
                hcount <= hcount + 1'b1;
                vcount <= vcount;
            end
        end
    end
    
    
        
    
    assign hsync = (hcount >= 0 && hcount < hs_end) ? 1'b1 : 1'b0;
    assign vsync = (vcount >= 0 && vcount < vs_end) ? 1'b1 : 1'b0;
    assign vde = (hcount >= hbp_end && hcount < hfp_begin && vcount >= vbp_end && vcount < vfp_begin) ? 1'b1: 1'b0;
    
    always @(posedge pix_clk) begin
    x_dir = hcount - hs_end - hfp_begin - hbp_end;
    y_dir = vcount - vs_end - vfp_begin - vbp_end;
            if ((y_dir >= box_y +14 && y_dir <= box_y + 18) || (y_dir >= box_y - 18 && y_dir <= box_y - 14) && x_dir >= box_x - 16 && x_dir <= box_x + 16)
            begin
                red = 4'b1111;
                blue = 4'b0000;
                green = 4'b0000;
            end
            else if ((x_dir >= box_x +14 && x_dir <= box_x + 18) || (x_dir >= box_x - 18 && x_dir <= box_x - 14) && y_dir >= box_y - 16 && y_dir <= box_y + 16)
            begin
                red = 4'b1111;
                blue = 4'b0000;
                green = 4'b0000;
            end
            else if (x_dir >= 290 && x_dir <= 310 && y_dir >= 238 && y_dir <= 242)
            begin
                red = 4'b1111;
                blue = 4'b0000;
                green = 4'b0000;
            end
            else if (x_dir >= 298 && x_dir <= 302 && y_dir >= 230 && y_dir <= 250)
            begin
                red = 4'b1111;
                blue = 4'b0000;
                green = 4'b0000;
            end
            else 
            begin
                red = 4'b1111;
                blue = 4'b1111;
                green = 4'b1111;
            end
        end
        //assign red = (vde == 1'b1) ? {sw[7:5], 5'h1F} : 8'h00;
        //assign green = (vde == 1'b1) ? {sw[4:2], 5'h1F} : 8'h00;
         //assign blue = (vde == 1'b1) ? {sw[1:0], 6'h3F} : 8'h00;
    
    
    srldelay # (
        .WIDTH(14),
        .TAPS(4'd1)
    ) vga_srldelay (
        .data_i({red, green, blue, hsync, vsync}),
        .data_o({vga_red, vga_green, vga_blue, vga_hsync, vga_vsync}),
        .clk(pix_clk)
    );
    
    
    assign hdmi_tx_hpd = 1'b1;
    
endmodule
