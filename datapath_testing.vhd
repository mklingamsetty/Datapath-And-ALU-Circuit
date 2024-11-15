library ieee;
use ieee.std_logic_1164.all;

entity tb_datapath is
end entity;

architecture behavior of tb_datapath is
	component datapath is
		port(clock, reset : in std_logic;
      alu_ctrl : in std_logic_vector(6 downto 0);
      input_bus : in std_logic_vector(2 downto 0);
		alu_out, a_out, b_out : out std_logic_vector(6 downto 0));
   end component;

   signal clock, reset : std_logic := '1';
   signal alu_ctrl, alu_out, a_out, b_out : std_logic_vector(6 downto 0) := (others => '0');
   signal input_bus : std_logic_vector(2 downto 0) := (others => '0');

   constant clk_period : time := 20 ns;
begin

   uut: datapath
		port map(clock => clock,
      reset      => reset,
      alu_ctrl   => alu_ctrl,
      input_bus  => input_bus,
      alu_out    => alu_out,
      a_out      => a_out,
      b_out      => b_out);

   clock_process : process
   begin
		while true loop
			clock <= '1';
         wait for clk_period / 2;
         clock <= '0';
         wait for clk_period / 2;
      end loop;
   end process;

   process
   begin
		reset <= '0';
      wait for clk_period;
      reset <= '1';

      wait for clk_period;

      alu_ctrl <= "00" & "10" & "000";
      input_bus <= "101";

      wait for clk_period;

      wait for clk_period / 2;
      assert a_out = "0010010" report "Test Case 1 Failed: a_out incorrect" severity error;

      alu_ctrl <= "10" & "00" & "000";
      input_bus <= "011";

      wait for clk_period;

      wait for clk_period / 2;
      assert b_out = "0110000" report "Test Case 2 Failed: b_out incorrect" severity error;

      wait;
   end process;
end architecture;