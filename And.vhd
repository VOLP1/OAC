library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;


entity PortaAnd is

port(
	A : in std_logic;
	B : in std_logic;
	Y : out std_logic
);

end PortaAnd;


architecture princ of PortaAnd is

begin

	Y <= (A and B);

end princ;