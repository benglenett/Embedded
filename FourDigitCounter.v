`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 01:52:48 PM
// Design Name: 
// Module Name: FourDigitCounter
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

//-        process(toggle2) begin
//--            if rising_edge(toggle2) then
               
//--            if (count3 >= 4) then
//--                count3 <= 0;
//--             else
//--                count3 <=count3 + 1;      
//--        end if;
        
//--        case count3 is 
//--            when 0 => 
//--            anodes <= "1110";
//--            digit_in <= digit1;
//--            when 1 => 
//--            anodes <= "1101";
//--            digit_in <= digit2; 
//--            when 2 => 
//--            anodes <= "1011";
//--            digit_in <= digit3; 
//--            when 3 => anodes 
//--            <= "0111";
//--            digit_in <= digit4; 
//--            when others => anodes <= "1111"; -- Blank 
//--        end case;
//--        case digit_in is
//--            when "0000" => segments <= "1000000"; -- 0
//--            when "0001" => segments <= "1111001"; -- 1
//--            when "0010" => segments <= "0100100"; -- 2
//--            when "0011" => segments <= "0110000"; -- 3
//--            when "0100" => segments <= "0011001"; -- 4
//--            when "0101" => segments <= "0010010"; -- 5
//--            when "0110" => segments <= "0000010"; -- 6
//--            when "0111" => segments <= "1111000"; -- 7
//--            when "1000" => segments <= "0000000"; -- 8
//--            when "1001" => segments <= "0010000"; -- 9
//--            when others => segments <= "1111111"; -- Blank
            
//--        end case;
//--        end if;
//--        end process;
        
// --and the ff outputs so when they are all equal it is stable

//module FourDigitCounter(
//    input wire clk,
//    input wire reset,
//    output wire [3:0] count_out
//);
//    reg [3:0] count = 4'b0000; 

//    always @(posedge clk or posedge reset) begin
//        if (reset) begin
//            count <= 4'd0; 
//        end else begin
//            if (count == 4'd9)   // Roll over at 9999
//                count <= 4'd0;
//            else
//                count <= count + 1;  // Increment counter
//        end
//    end

//    assign count_out = count; // Pad with zero for 16-bit output
//endmodule