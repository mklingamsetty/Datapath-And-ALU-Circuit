library ieee;
use ieee.std_logic_1164.all;

entity datapath is
    Port (
        reset      : in  STD_LOGIC;     -- Reset signal
        clk     : in  STD_LOGIC;     -- clk input for manual clock
        ALU_CTRL   : in  STD_LOGIC_VECTOR (6 downto 0);  -- [SELA][SELB][OP]
        input_bus  : in  STD_LOGIC_VECTOR (2 downto 0);  -- 3-bit input bus
        seg_display, seg_displayA, seg_displayB, seg_displayC_out : out STD_LOGIC_VECTOR (6 downto 0)  -- 7-segment display outputs
    );
end entity;

architecture logic of datapath is
    -- Rename internal signals to match output names in the `datapath` entity
    signal A_in, B_in, ALU_out : std_logic_vector(3 downto 0) := (others => '0');
    signal A_out, B_out, CarryOut : std_logic_vector(3 downto 0) := (others => '0');
    signal C_out : std_logic := '0';

begin
    -- Instantiate Register A with clk as clock
    regi_A : entity work.Register_4bit
        port map (
            clk => clk, 
            reset => reset, 
            input => A_in, 
            output => A_out
        );

    -- Instantiate Register B with clk as clock
    regi_B : entity work.Register_4bit
        port map (
            clk => clk, 
            reset => reset, 
            input => B_in, 
            output => B_out
        );

    -- Instantiate the ALU component
    alu_data : entity work.alu
        port map (
            a => A_out, 
            b => B_out, 
            op => ALU_CTRL(2 downto 0), 
            c_in => '0', 
            f_out => ALU_out, 
            c_out => C_out
        );

    -- Mux logic for A_in and B_in based on ALU_CTRL signals
    process(clk, reset)
    begin
        -- MUX selection for A_in
        case ALU_CTRL(6 downto 5) is
            when "00" =>
                A_in <= '0' & input_bus;  -- Extend input_bus to 4 bits
            when "01" =>
                A_in <= ALU_out;
            when "10" =>
                A_in <= A_out;
            when "11" =>
                A_in <= B_out;
        end case;

        -- MUX selection for B_in
        case ALU_CTRL(4 downto 3) is
            when "00" =>
                B_in <= '0' & input_bus;  -- Extend input_bus to 4 bits
            when "01" =>
                B_in <= ALU_out;
            when "10" =>
                B_in <= A_out;
            when "11" =>
                B_in <= B_out;
        end case;
    end process;

    -- 7-segment display converter components
    alu_hex : entity work.Converter
        port map(number_in => ALU_out, number_out => seg_display);

    a_hex : entity work.Converter
        port map(number_in => A_out, number_out => seg_displayA);

    b_hex : entity work.Converter
        port map(number_in => B_out, number_out => seg_displayB);
		  
	 c_hex : entity work.Converter
        port map(number_in => "000" & C_out, number_out => seg_displayC_out);
end architecture;
