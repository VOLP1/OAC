-- Testbench  XREG
library IEEE;
use IEEE.std_logic_1164.all;
 
entity TB_XREG is

end TB_XREG; 

architecture tb of TB_XREG is

-- DUT component
component XREGS is
	port(
		clk, wren, rst	:	in		std_logic;
		rs1, rs2, rd	:	in		std_logic_vector(4 downto 0);
		data				:	in		std_logic_vector(31 downto 0);
		ro1, ro2			:	out	std_logic_vector(31 downto 0)
	);
end component;

signal wren_in, rst_in: std_logic;
signal clk_in : std_logic := '0';
signal rs1_in, rs2_in, rd_in: std_logic_vector(4 downto 0);
signal data_in, ro1_out, ro2_out: std_logic_vector(31 downto 0);

begin

  -- Connect DUT
  DUT: XREGS port map(clk => clk_in, wren => wren_in, rst => rst_in, rs1 => rs1_in, rs2 => rs2_in, rd => rd_in, data => data_in, ro1 => ro1_out, ro2 => ro2_out);

	process
	begin
		clk_in <= '0';
		wait for 5 ns;
		clk_in <= '1';
		wait for 5 ns;
	end process;
	
	process
	begin   
		wren_in <= '1';
		rst_in <= '1';
		rs1_in <= "00000";
		rs2_in <= "00001";
		wait for 10 ns; --reset
        
        wren_in <= '0';
		rd_in <= "10101";
		data_in <= x"98765432";
		wait for 10 ns;
		rd_in <= "11001";
		data_in <= x"F56E3D4C";	-- enable desabilitado (não escreve)
		wait for 10 ns;
		
		wren_in <= '1';
		rst_in <= '0';
		rd_in <= "10101";
		data_in <= x"854D76F2"; 
		wait for 10 ns;
		rd_in <= "11001";
		data_in <= x"F0FA5678";
		wait for 10 ns;	-- Escreve valores
        
		
		rs1_in <= "00010";
		rs2_in <= "00001";
		assert(ro1_out = x"00000000") report "Teste 1 falhou em ro1!" severity error;
		assert(ro2_out = x"00000000")	report "Teste 1 falhou em ro2!" severity error;
		wait for 10 ns;
		
		rs1_in <= "00000";
		rs2_in <= "01011";
		assert(ro1_out = x"00000000") report "Teste 1 falhou em ro1!" severity error;
		assert(ro2_out = x"00000000")	report "Teste 1 falhou em ro2!" severity error;
		wait for 10 ns;
		
		rs1_in <= "10001";
		rs2_in <= "10101";
		assert(ro1_out = x"15A3B212") report "Teste 1 falhou em ro1!" severity error;
		assert(ro2_out = x"FACAF0FA")	report "Teste 1 falhou em ro2!" severity error;
		wait for 10 ns;	-- Leitura de alguns registradores
    
	end process;
end tb;
