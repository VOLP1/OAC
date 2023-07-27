library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;


entity AddPC is

port(
	A : in std_logic_vector(31 downto 0);
	Z : out std_logic_vector(31 downto 0)
);

end AddPC;


architecture princ of AddPC is
begin

	Z <= std_logic_vector(unsigned(A) + 4);

end princ;