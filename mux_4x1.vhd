library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_4x1 is
    Port (
        D0, D1, D2, D3 : in STD_LOGIC_VECTOR (3 downto 0);
        SEL : in STD_LOGIC_VECTOR (1 downto 0);
        MUX_OUT : out STD_LOGIC_VECTOR (3 downto 0)
    );
end mux_4x1;

architecture Behavioral of mux_4x1 is
begin
    process (D0, D1, D2, D3, SEL)
    begin
        case SEL is
            when "00" => MUX_OUT <= D0;
            when "01" => MUX_OUT <= D1;
            when "10" => MUX_OUT <= D2;
            when "11" => MUX_OUT <= D3;
            --when others => MUX_OUT <= (others => '0');
        end case;
    end process;
end Behavioral;
