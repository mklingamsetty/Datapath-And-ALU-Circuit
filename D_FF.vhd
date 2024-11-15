library ieee;
use ieee.std_logic_1164.all;

entity D_FF is
	port(
			clk, 
			reset, 
			d : in std_logic;
			q : out std_logic);
end entity;

architecture logic of D_FF is
begin
	process(clk, reset)
	begin
		if(reset = '0') then
			q <= '0';
		elsif falling_edge(clk) then
			q <= d;
		end if;
	end process;
end architecture;
