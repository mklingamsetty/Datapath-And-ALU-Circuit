library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity alu is
    port(
        a, b   : in std_logic_vector(3 downto 0);
        op     : in std_logic_vector(2 downto 0);
        c_in   : in std_logic;
        f_out  : out std_logic_vector(3 downto 0);
        c_out  : out std_logic
    );
end entity;

architecture logic of alu is
    signal sum : std_logic_vector(4 downto 0); -- 5-bit signal to hold sum with carry
begin
    process(a, b, op, c_in)
    begin
        case op is
            when "000" =>
                f_out <= not a;
                c_out <= '0';

            when "001" =>
                f_out <= a and b;
                c_out <= '0';

            when "010" =>
                f_out <= a or b;
                c_out <= '0';

            when "011" =>
                -- Perform 4-bit addition with carry-in, storing result in a 5-bit vector
                sum <= ('0' & a) + ('0' & b) + ("0000" & c_in);
                f_out <= sum(3 downto 0);   -- Assign lower 4 bits of the sum to `f_out`
                c_out <= sum(4);            -- Assign the 5th bit of sum as `c_out` (carry out)

            when "100" =>
                f_out <= a;
                c_out <= '0';

            when "101" =>
                f_out <= b;
                c_out <= '0';

            when "110" =>
                f_out <= a(2 downto 0) & '0';
                c_out <= '0';

            when "111" =>
                f_out <= '0' & a(3 downto 1);
                c_out <= '0';

            when others =>
                f_out <= (others => '0');
                c_out <= '0';
        end case;
    end process;
end architecture;
