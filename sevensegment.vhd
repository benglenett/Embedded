----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/04/2024 01:42:08 PM
-- Design Name: 
-- Module Name: sevensegment - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

--entity SevenSegment is
--    Port (
--        digit_in   : in  STD_LOGIC_VECTOR(3 downto 0);
--        digit_select   : in  STD_LOGIC_VECTOR(1 downto 0);
--        segments   : out STD_LOGIC_VECTOR(7 downto 0);
--        anodes     : out STD_LOGIC_VECTOR(3 downto 0)
--    );
--end SevenSegment;

--architecture Behavioral of SevenSegment is
--begin
--    anodes <= "0000"; --ensure anodes are on 
--    process(digit_select)
--    begin
--        case digit_select is
--            when "00" => anodes <= "1110"; -- 1
--            when "01" => anodes <= "1101"; -- 2
--            when "10" => anodes <= "1011"; -- 3
--            when "11" => anodes <= "0111"; -- 4

--        end case;
--     end process;   
--    process(digit_in)
--    begin
--        case digit_in is
--            when "0000" => segments <= "10000001"; -- 0
--            when "0001" => segments <= "11001111"; -- 1
--            when "0010" => segments <= "10010010"; -- 2
--            when "0011" => segments <= "10000110"; -- 3
--            when "0100" => segments <= "11001100"; -- 4
--            when "0101" => segments <= "10100100"; -- 5
--            when "0110" => segments <= "10100000"; -- 6
--            when "0111" => segments <= "10001111"; -- 7
--            when "1000" => segments <= "10000000"; -- 8
--            when "1001" => segments <= "10000100"; -- 9
--            when others => segments <= "11111111"; -- Blank
--        end case;
--    end process;
--end Behavioral;