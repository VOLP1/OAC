library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;


entity add_pc is

port(
	A : in std_logic_vector(31 downto 0);
	Z : out std_logic_vector(31 downto 0)
);

end add_pc;


architecture princ of add_pc is
begin

	Z <= std_logic_vector(unsigned(A) + 4);

end princ;