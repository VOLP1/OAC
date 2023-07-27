
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity RegEM is

generic(WSIZE : natural := 32);      
    
port(
	clk : in std_logic;
	
	wb_in, branch_in, zero_in, memread_in, memwrite_in : in std_logic;
	wb_out, branch_out, zero_out, memread_out, memwrite_out : out std_logic;
	rd_in : in std_logic_vector(4 downto 0);
	rd_out : out std_logic_vector(4 downto 0);
	rs2_in, pc_in, ula_in : in std_logic_vector(WSIZE -1 downto 0);
	rs2_out, pc_out, ula_out : out std_logic_vector(WSIZE -1 downto 0)
);
end RegEM;

architecture princ of RegEM is

begin

process(clk) begin

	if rising_edge(clk) then
		wb_out <= wb_in;
		branch_out <= branch_in;
		zero_out <= zero_in;
		rd_out <= rd_in;
		rs2_out <= rs2_in;
		pc_out <= pc_in;
		ula_out <= ula_in;
		memread_out <= memread_in;
		memwrite_out <= memwrite_in;
	end if;

end process;

end princ;