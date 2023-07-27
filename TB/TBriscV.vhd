
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testbench is
	generic(WSIZE : natural := 32);
end testbench;

architecture test of testbench is

component Processador is
generic(WSIZE : natural := 32);
port(
	clk: in std_logic);
end component;

signal clk: std_logic;

begin

	DUT: Processador port map(
	clk => clk
	);

	process
	begin
		clk <= '0';
		wait for 5 ns;
		clk <= '1';
		wait for 5 ns;
	end process;

	process
	begin
	
		wait for 100 ns;		
		
	end process;
	
end test;
