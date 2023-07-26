
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity MW is

generic(WSIZE : natural := 32);      
    
port(
	clk : in std_logic;
	
	wb_in, memread_in : in std_logic;
	wb_out, memread_out : out std_logic;
	rd_in : in std_logic_vector(4 downto 0);
	rd_out : out std_logic_vector(4 downto 0);
	ula_in, memo_data_in : in std_logic_vector(WSIZE -1 downto 0);
	ula_out, memo_data_out : out std_logic_vector(WSIZE -1 downto 0)
);
end MW;

architecture princ of MW is

begin

process(clk) begin

	if rising_edge(clk) then
		wb_out <= wb_in;
		rd_out <= rd_in;
		ula_out <= ula_in;
		memo_data_out <= memo_data_in;
		memread_out <= memread_in;
	end if;

end process;

end princ;