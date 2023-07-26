library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;


entity porta_and is

port(
	A : in std_logic;
	B : in std_logic;
	Y : out std_logic
);

end porta_and;


architecture princ of porta_and is

begin

	Y <= (A and B);

end princ;