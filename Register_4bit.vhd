library ieee;
use ieee.std_logic_1164.all;

entity Register_4bit is
	port(
	clk, reset : in std_logic;
	input : in std_logic_vector(3 downto 0);
	output : out std_logic_vector(3 downto 0));
end entity;

architecture logic of Register_4bit is
begin

	D_FF_3 : entity work.D_FF
		port map(
		clk => clk,
		reset => reset, 
		d => input(3), 
		q => output(3));
		
	D_FF_2 : entity work.D_FF
		port map(
		clk => clk, 
		reset => reset, 
		d => input(2), 
		q => output(2));
		
	D_FF_1 : entity work.D_FF
		port map(
		clk => clk, 
		reset => reset, 
		d => input(1), 
		q => output(1));
		
	D_FF_0 : entity work.D_FF
		port map(
		clk => clk, 
		reset => reset, 
		d => input(0), 
		q => output(0));
		
end architecture;