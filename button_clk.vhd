library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity button_clk is
    Port (
        button      : in  STD_LOGIC;    -- Button input
        clk_in      : in  STD_LOGIC;    -- Main system clock for sampling
        reset       : in  STD_LOGIC;    -- Reset signal
        manual_clk  : out STD_LOGIC     -- Output clock pulse generated from button
    );
end button_clk;

architecture Behavioral of button_clk is
    signal button_sync_0, button_sync_1 : STD_LOGIC := '1';  -- Synchronize button signal
    signal button_rising_edge           : STD_LOGIC := '0';  -- Detect button release
begin
    -- Synchronize button signal to prevent metastability
    process (clk_in, reset)
    begin
        if reset = '0' then
            button_sync_0 <= '1';
            button_sync_1 <= '1';
            button_rising_edge <= '0';
        elsif rising_edge(clk_in) then
            button_sync_0 <= button;
            button_sync_1 <= button_sync_0;
            button_rising_edge <= button_sync_0 and not button_sync_1;
        end if;
    end process;

    -- Generate manual clock pulse based on button release
    manual_clk <= button_rising_edge;

end Behavioral;
