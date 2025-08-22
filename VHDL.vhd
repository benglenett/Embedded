----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/06/2024 01:48:43 PM
-- Design Name: 
-- Module Name: VHDL - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ClockDivider is
    Port (
        clk       : in  STD_LOGIC;
        reset     : in  STD_LOGIC; 
        twice    : in  STD_LOGIC;
        halve     : in  STD_LOGIC;
        clk_out   : out STD_LOGIC;
        div_value : out INTEGER
    );
end ClockDivider;

architecture Behavioral of ClockDivider is
    signal clk_div : INTEGER := 100000;   -- Start at 1ms 
    signal counter : INTEGER := 0;
    signal toggle  : STD_LOGIC := '0';
begin
    process(clk, reset)
    begin
        if reset = '1' then
            clk_div <= 100000; -- Reset to 1ms period (1kHz)
            counter <= 0;
            toggle <= '0';
        elsif rising_edge(clk) then
            if twice = '1' and clk_div > 12500 then
                clk_div <= clk_div / 2; -- Double frequency
            elsif halve = '1' and clk_div < 800000 then
                clk_div <= clk_div * 2; -- Halve frequency
            end if;

            if counter >= clk_div then
                counter <= 0;
                toggle <= not toggle; -- Toggle output clock
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    clk_out <= toggle;
    div_value <= clk_div; -- Expose the current divider value
end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ClockDivider100 is
    Port (
        clk       : in  STD_LOGIC;
        reset     : in  STD_LOGIC; 
        twice    : in  STD_LOGIC;
        halve     : in  STD_LOGIC;
        clk_out   : out STD_LOGIC;
        div_value : out INTEGER
    );
end ClockDivider100;

architecture Behavioral of ClockDivider100 is
    signal clk_div : INTEGER := 1000;   -- Start at 10us 
    signal counter : INTEGER := 0;
    signal toggle  : STD_LOGIC := '0';
begin
    process(clk, reset)
    begin
        if reset = '1' then
            clk_div <= 1000; -- Reset to 10us period (100kHz)
            counter <= 0;
            toggle <= '0';
        elsif rising_edge(clk) then
            if twice = '1' and clk_div > 12500 then
                clk_div <= clk_div / 2; -- Double frequency
            elsif halve = '1' and clk_div < 800000 then
                clk_div <= clk_div * 2; -- Halve frequency
            end if;

            if counter >= clk_div then
                counter <= 0;
                toggle <= not toggle; -- Toggle output clock
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    clk_out <= toggle;
    div_value <= clk_div; -- Expose the current divider value
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FourDigitCounter is
    Port (
        clk       : in  STD_LOGIC;
        reset     : in  STD_LOGIC;
        count_out : out STD_LOGIC_VECTOR(15 downto 0) -- BCD counter output
    );
end FourDigitCounter;

architecture Behavioral of FourDigitCounter is
    signal count : INTEGER := 0;
begin
    process(clk, reset)
    begin
        if reset = '1' then
            count <= 0;
        elsif rising_edge(clk) then
            if count = 9999 then
                count <= 0; -- Roll over
            else
                count <= count + 1;
            end if;
        end if;
    end process;

    count_out <= std_logic_vector(to_unsigned(count, 16));
end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RGBIndicator is
    Port (
        clk_div_value : in  INTEGER;
        RGB_out       : out STD_LOGIC_VECTOR(2 downto 0)
    );
end RGBIndicator;

architecture Behavioral of RGBIndicator is
begin
    process(clk_div_value)
    begin
        if clk_div_value = 100000 then -- 1kHz
            RGB_out <= "111"; 
        elsif clk_div_value > 100000 then -- Below 1kHz
            RGB_out <= "100";
        else -- Above 1kHz
            RGB_out <= "010";
        end if;
    end process;
end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SevenSegmentDisplayDriver is
    Port (
        clk       : in  STD_LOGIC; 
        reset     : in  STD_LOGIC;
        value     : in  STD_LOGIC_VECTOR(15 downto 0);
        seg       : out STD_LOGIC_VECTOR(6 downto 0);  
        an        : out STD_LOGIC_VECTOR(3 downto 0)  
    );
end SevenSegmentDisplayDriver;

architecture Behavioral of SevenSegmentDisplayDriver is
    signal digit_select : INTEGER := 0;
    signal current_digit : STD_LOGIC_VECTOR(3 downto 0);
begin
    process(clk, reset)
    begin
        if reset = '1' then
            digit_select <= 0;
        elsif rising_edge(clk) then
        if digit_select < 4 then
            digit_select <= (digit_select + 1);
            else
            digit_select <= 0;
        end if;
        end if;
    end process;

    process(digit_select, value)
    begin
        case digit_select is
            when 0 =>
                an <= "1110";
                current_digit <= value(3 downto 0);
            when 1 =>
                an <= "1101";
                current_digit <= value(7 downto 4);
            when 2 =>
                an <= "1011";
                current_digit <= value(11 downto 8);
            when 3 =>
                an <= "0111";
                current_digit <= value(15 downto 12);
            when others =>
                an <= "1111";
        end case;

        case current_digit is
            when "0000" => seg <= "1000000"; -- 0
            when "0001" => seg <= "1111001"; -- 1
            when "0010" => seg <= "0100100"; -- 2
            when "0011" => seg <= "0110000"; -- 3
            when "0100" => seg <= "0011001"; -- 4
            when "0101" => seg <= "0010010"; -- 5
            when "0110" => seg <= "0000010"; -- 6
            when "0111" => seg <= "1111000"; -- 7
            when "1000" => seg <= "0000000"; -- 8
            when "1001" => seg <= "0010000"; -- 9
            when others => seg <= "1111111"; -- Blank
        end case;
    end process;
end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BinaryToBCD is
    Port (
        binary_in : in  STD_LOGIC_VECTOR(15 downto 0);
        bcd_out   : out STD_LOGIC_VECTOR(15 downto 0)
    );
end BinaryToBCD;

architecture Behavioral of BinaryToBCD is
    -- Internal signals for BCD digits
    signal bcd_digit3 : INTEGER := 0; -- Thousands
    signal bcd_digit2 : INTEGER := 0; -- Hundreds
    signal bcd_digit1 : INTEGER := 0; -- Tens
    signal bcd_digit0 : INTEGER := 0; -- Ones
    signal binary_value : INTEGER := 0;
begin
    process(binary_in)
    begin
        -- Convert binary_in to integer for processing
        binary_value <= to_integer(unsigned(binary_in));

       
        bcd_digit3 <= binary_value / 1000;              -- Thousands
        bcd_digit2 <= (binary_value mod 1000) / 100;    -- Hundreds
        bcd_digit1 <= (binary_value mod 100) / 10;      -- Tens
        bcd_digit0 <= binary_value mod 10;              -- ones

        -- Combine into a 16-bit BCD output
        bcd_out <= std_logic_vector(to_unsigned(bcd_digit3, 4)) &
                   std_logic_vector(to_unsigned(bcd_digit2, 4)) &
                   std_logic_vector(to_unsigned(bcd_digit1, 4)) &
                   std_logic_vector(to_unsigned(bcd_digit0, 4));
    end process;
    
end Behavioral;


--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

--entity DebounceLatch is
--    Port (
--        clk       : in  STD_LOGIC;
--        reset     : in  STD_LOGIC;
--        btn       : in  STD_LOGIC;
--        btn_latch : out STD_LOGIC 
--    );
--end DebounceLatch;

--architecture Behavioral of DebounceLatch is
--    constant DEBOUNCE_TIME : integer := 1000000;
--    signal counter         : integer := 0;
--    signal btn_stable      : STD_LOGIC := '0'; 
--    signal btn_last        : STD_LOGIC := '0';
--    signal btn_sync1       : STD_LOGIC := '0'; 
--    signal btn_sync2       : STD_LOGIC := '0';
--begin
--    -- Synchronize the raw button input to the system clock
--    process(clk)
--    begin
--        if rising_edge(clk) then
--            btn_sync1 <= btn;
--            btn_sync2 <= btn_sync1;
--        end if;
--    end process;

--   
--    process(clk, reset)
--    begin
--        if reset = '1' then
--            counter <= 0;
--            btn_stable <= '0';
--        elsif rising_edge(clk) then
--            if btn_sync2 = btn_stable then
--                counter <= 0;
--            else
--                counter <= counter + 1;
--                if counter >= DEBOUNCE_TIME then
--                    btn_stable <= btn_sync2; 
--                    counter <= 0;
--                end if;
--            end if;
--        end if;
--    end process;

--    -- Generate a single pulse on the rising edge of the stable signal
--    process(clk, reset)
--    begin
--        if reset = '1' then
--            btn_last <= '0';
--            btn_latch <= '0';
--        elsif rising_edge(clk) then
--            if btn_stable = '1' and btn_last = '0' then
--                btn_latch <= '1'; -- Rising edge detected
--            else
--                btn_latch <= '0'; -- No pulse
--            end if;
--            btn_last <= btn_stable; -- Update last state
--        end if;
--    end process;
--end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity EdgeDetector is
    Port (
        clk       : in  STD_LOGIC;
        reset     : in  STD_LOGIC;
        btn_in    : in  STD_LOGIC;
        btn_latch : out STD_LOGIC
    );
end EdgeDetector;

architecture Behavioral of EdgeDetector is
    signal btn_last : STD_LOGIC := '0';
begin
    
    process(clk, reset)
    begin
        if reset = '1' then
            btn_last <= '0';
            btn_latch <= '0';
        elsif rising_edge(clk) then
            if btn_in = '1' and btn_last = '0' then
                btn_latch <= '1'; -- Rising edge detected
            else
                btn_latch <= '0';
            end if;
            btn_last <= btn_in; 
        end if;
    end process;
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Debouncer is
    Port (
        clk       : in  STD_LOGIC;
        reset     : in  STD_LOGIC;
        btn_in    : in  STD_LOGIC;
        btn_out   : out STD_LOGIC
    );
end Debouncer;

architecture Behavioral of Debouncer is
    constant DEBOUNCE_TIME : integer := 10000;
    signal counter         : integer := 0;
    signal btn_stable      : STD_LOGIC := '0';
    signal btn_sync1       : STD_LOGIC := '0';
    signal btn_sync2       : STD_LOGIC := '0'; 
begin

    process(clk)
    begin
        if rising_edge(clk) then
            btn_sync1 <= btn_in;
            btn_sync2 <= btn_sync1;
        end if;
    end process;


    process(clk, reset)
    begin
        if reset = '1' then
            counter <= 0;
            btn_stable <= '0';
        elsif rising_edge(clk) then
            if btn_sync2 = btn_stable then
                counter <= 0;
            else
                counter <= counter + 1;
                if counter >= DEBOUNCE_TIME then
                    btn_stable <= btn_sync2; 
                    counter <= 0;
                end if;
            end if;
        end if;
    end process;

    btn_out <= btn_stable;
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Wrapper is
    Port (
        clk       : in  STD_LOGIC;
        reset     : in  STD_LOGIC;
        btn       : in STD_LOGIC;
        twice    : in  STD_LOGIC;
        halve     : in  STD_LOGIC;
        seg       : out STD_LOGIC_VECTOR(6 downto 0);
        an        : out STD_LOGIC_VECTOR(3 downto 0);
        RGB_out   : out STD_LOGIC_VECTOR(2 downto 0)
    );
end Wrapper;

architecture Behavioral of Wrapper is
    signal clk_divided : STD_LOGIC;
--    signal clk_divided2 : STD_LOGIC;
    signal clk_div_value : INTEGER := 100000;
--    signal clk_div_value2 : INTEGER := 5000000;
    signal counter_value : STD_LOGIC_VECTOR(15 downto 0);
--    signal counter_value2 : STD_LOGIC_VECTOR(15 downto 0);
   signal bcd_out   :STD_LOGIC_VECTOR(15 downto 0);
--     signal twice_latch : STD_LOGIC := '0';
--    signal halve_latch  : STD_LOGIC := '0';
--    signal reset_latch  : STD_LOGIC := '0';
--    signal twice_debounced : STD_LOGIC := '0';
--    signal halve_debounced  : STD_LOGIC := '0';
--    signal reset_debounced  : STD_LOGIC := '0';
    signal fakebtn1 : STD_LOGIC := '0';
    signal fakebtn2 : STD_LOGIC := '0';
    signal fakebtn3 : STD_LOGIC := '0';
    signal btn_latched : STD_LOGIC := '0';
    signal btn_stable : STD_LOGIC := '0';
    signal btn_stable_not : STD_LOGIC := '0';
    signal btn_released : STD_LOGIC := '0';
    signal press_time   : STD_LOGIC_VECTOR(15 downto 0);
    signal counting     : STD_LOGIC := '0';
    signal counting_value     : STD_LOGIC := '0';
    
    
    
begin
      DoubleDebounce: entity work.Debouncer
    Port map (
        clk       => clk,
        reset     => reset,
        btn_in    => btn,
        btn_out   => btn_stable
    );

 ClockDivider2_inst: entity work.ClockDivider100
        Port map (
            clk       => clk,
            reset     => reset,
            twice    => fakebtn1,
            halve     => fakebtn2,
            clk_out   => clk_divided,
            div_value => clk_div_value
        );
        
    EdgeDetectorPress: entity work.EdgeDetector
        Port map (
            clk       => clk_divided,
            reset     => reset,
            btn_in    => btn,
            btn_latch => btn_latched 
        );

    btn_stable_not <= not btn;
    
    EdgeDetectorRelease: entity work.EdgeDetector
        Port map (
            clk       => clk_divided,
            reset     => reset,
            btn_in    => btn_stable_not,
            btn_latch => btn_released
        );
        
         
        
         process(clk_divided, reset)
    begin
        if reset = '1' then
            press_time <= "0000000000000000";
            counting <= '0';
        elsif rising_edge(clk_divided) then
            if btn_latched = '1' then
                counting <= '1';
                press_time <= "0000000000000000";
            elsif btn_released = '1' then
                counting <= '0';
            elsif counting = '1' then
                if press_time < 9999 then
                    press_time <= press_time + 1;
                end if;
            end if;
        end if;
    end process;
 
        
      Binarytobcd_inst : entity work.BinaryToBCD
      Port map(
        binary_in  => press_time,
        bcd_out => bcd_out
      );



    Display_inst: entity work.SevenSegmentDisplayDriver
        Port map (
            clk       => clk_divided,
            reset     => reset,
            value     => bcd_out,
            seg       => seg,
            an        => an
        );
        
--  DoubleDebounce: entity work.Debouncer
--    Port map (
--        clk       => clk,
--        reset     => reset,
--        btn_in    => twice,
--        btn_out   => twice_debounced
--    );

--DoubleLatch: entity work.EdgeDetector
--    Port map (
--        clk       => clk,
--        reset     => reset,
--        btn_in    => twice_debounced, 
--        btn_latch => twice_latch 
--    );

--HalveDebounce: entity work.Debouncer
--    Port map (
--        clk       => clk,
--        reset     => reset,
--        btn_in    => halve,
--        btn_out   => halve_debounced 
--    );

--HalveLatch: entity work.EdgeDetector
--    Port map (
--        clk       => clk,
--        reset     => reset,
--        btn_in    => halve_debounced,
--        btn_latch => halve_latch
--    );
    

--    ClockDivider_inst: entity work.ClockDivider
--        Port map (
--            clk       => clk,
--            reset     => reset,
--            twice    => twice_latch,
--            halve     => halve_latch,
--            clk_out   => clk_divided,
--            div_value => clk_div_value
--        );
    



--    Counter_inst: entity work.FourDigitCounter
--        Port map (
--            clk       => clk_divided,
--            reset     => reset,
--            count_out => counter_value
--        );


--    RGB_inst: entity work.RGBIndicator
--        Port map (
--            clk_div_value => clk_div_value,
--            RGB_out       => RGB_out
--        );

 end Behavioral;

--entity VHDL is
--    Port (
--        clk   : in STD_LOGIC;
--        btn   : in STD_LOGIC_VECTOR(3 downto 0);
--        sw   : out STD_LOGIC_VECTOR(7 downto 0);
--        segments   : out STD_LOGIC_VECTOR(6 downto 0);
--        anodes     : out STD_LOGIC_VECTOR(3 downto 0);
--        RGB_out       : out STD_LOGIC_VECTOR(2 downto 0)
        
--  );
--end VHDL;

--architecture Behavioral of VHDL is
--        signal ff1 : STD_LOGIC_VECTOR(3 downto 0) := "0000";
--        signal ff2: STD_LOGIC_VECTOR(3 downto 0) := "0000";
--        signal ff3 : STD_LOGIC_VECTOR(3 downto 0) := "0000";
--        signal rst : STD_LOGIC := '0';
--        signal debounce_out : STD_LOGIC_VECTOR(3 downto 0);
--        signal clk_div : integer := 100000; -- Start at 1ms (1kHz assuming 100MHz input clock)
--        signal clk_div2 : integer := 1000000; -- Start at 1ms (100Hz assuming 100MHz input clock)
--        signal count1   : integer := 0;
--        signal count2   : integer := 0;
--        signal count3   : integer := 0;
--        signal toggle1  : STD_LOGIC := '0';
--        signal toggle2 : STD_LOGIC := '0';
--        signal digit1 : STD_LOGIC_VECTOR(3 downto 0) := "0000";
--        signal digit2 : STD_LOGIC_VECTOR(3 downto 0) := "0000";
--        signal digit3 : STD_LOGIC_VECTOR(3 downto 0) := "0000";
--        signal digit4 : STD_LOGIC_VECTOR(3 downto 0) := "0000";
--        signal anode_and : STD_LOGIC_VECTOR(3 downto 0) := "0000";
--        signal digit_in : STD_LOGIC_VECTOR(3 downto 0) := "0000";
--        signal toggle_hold : STD_LOGIC :='0';
        
--    begin
    
--    rst <= btn(3);
--     debounce_out <= ff1 and ff2 and ff3;
--    process(clk, rst)
--    begin
--    if rst = '1' then
--        ff1 <= "0000";
--        ff2 <= "0000";
--        ff3 <= "0000";
--        clk_div <= 100000;
--        clk_div2 <= 100000;
--        count1 <= 0;
--        count2 <= 0;
--        toggle1 <= '0';
--        toggle2 <= '0';
--        RGB_out <= "000";
--        anode_and <= "0000";
--    elsif rising_edge(clk) then
--        ff1 <= btn(3 downto 0);
--        ff2 <= ff1;
--        ff3 <= ff2;
        
--        if btn(1) = '1' and clk_div > 12500 then
--           clk_div <= clk_div / 2;
        
--        elsif btn(0) = '1' and clk_div < 800000 then
--                clk_div <= clk_div * 2;
--        end if;
        
--        if count1 >= clk_div then
--                count1 <= 0;
--                toggle1 <= not toggle1;
--                if toggle_hold = '0' and toggle1 = '1' then
--                    toggle_hold <= '1';
--                 else
--                    toggle_hold <= '0';                   
--                end if;
--            else
--                count1 <= count1 + 1;
--         end if;
         
--          if count2 >= clk_div2 then
--                count2 <= 0;
--                toggle2 <= not toggle2;
--            else
--                count2 <= count2 + 1;
--        end if;
        
--         if clk_div < 100000 then -- 1kHz
--            RGB_out <= "010"; -- Green
--        elsif clk_div > 100000 then -- Below 1kHz
--            RGB_out <= "001"; -- Red
--        else -- Above 1kHz
--            RGB_out <= "111"; -- Red
--        end if;
--         end if;
--         end process;
         
--        process(clk, rst)
--        begin
--        if rst = '1' then
        
      
--        toggle_hold <= '0';
--        count3 <= 0;
--        digit1 <= "0000";
--        digit2 <= "0000";
--        digit3 <= "0000";
--        digit4 <= "0000";
--        digit_in <= "0000";
--        segments <= "1111111";
--        anodes <= "1111";
--        end if;
--        if rising_edge(clk) then
--         if toggle_hold = '1' then
--         if digit1 = "1001" then 
--            digit1 <= "0000";
--            digit2 <= digit2 + 1;
--            if digit2 = "1010" then 
--                digit2 <= "0000";
--                digit3 <= digit3 + 1;
--                if digit3 = "1010" then 
--                        digit3 <= "0000";
--                        digit4 <= digit4 + 1;
--                    if digit4 = "1010" then 
--                        digit4 <= "0000";
--                    end if;
--                end if;
--            end if;
--        else
--            digit1 <= digit1 + 1;
--        end if;
        
--         if (count3 >= 4) then
--                count3 <= 0;
--             else
--                count3 <=count3 + 1;      
--        end if;
        
--        case count3 is 
--            when 0 => 
--            anodes <= "1110";
--            digit_in <= digit1;
--            when 1 => 
--            anodes <= "1101";
--            digit_in <= digit2; 
--            when 2 => 
--            anodes <= "1011";
--            digit_in <= digit3; 
--            when 3 => 
--            anodes <= "0111";
--            digit_in <= digit4; 
--            when others => anodes <= "1111"; -- Blank 
--        end case;
--        case digit_in is
--            when "0000" => segments <= "1000000"; -- 0
--            when "0001" => segments <= "1111001"; -- 1
--            when "0010" => segments <= "0100100"; -- 2
--            when "0011" => segments <= "0110000"; -- 3
--            when "0100" => segments <= "0011001"; -- 4
--            when "0101" => segments <= "0010010"; -- 5
--            when "0110" => segments <= "0000010"; -- 6
--            when "0111" => segments <= "1111000"; -- 7
--            when "1000" => segments <= "0000000"; -- 8
--            when "1001" => segments <= "0010000"; -- 9
--            when others => segments <= "1111111"; -- Blank
            
--        end case;
        
--       end if;

--      end if;
      
        
-- end process;
 
 
    
    
    

--end Behavioral;




