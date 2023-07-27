library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;


entity Add is

port(
	pc_in, imm : in std_logic_vector(31 downto 0);
	pc_out : out std_logic_vector(31 downto 0)
);

end Add;

architecture princ of Add is

begin
	pc_out <= std_logic_vector(shift_left(unsigned(imm), 1) + unsigned(pc_in));
end princc;