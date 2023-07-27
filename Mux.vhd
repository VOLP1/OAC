library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    use IEEE.STD_LOGIC_UNSIGNED.ALL;
    use IEEE.numeric_std.all;

entity Mux is 
	generic (WSIZE : natural := 32);
	port (
		a, b : in std_logic_vector(WSIZE-1 downto 0);
		ctrl : in std_logic;
		z : out std_logic_vector(WSIZE-1 downto 0)
	);
end Mux;

architecture princ of Mux is

begin
	process(ctrl, a, b)
	begin
		case ctrl is
			when '0' => z <= a;
			when '1' => z <= b;
			when others => z <= (others => '0');
		end case;
	end process;
end princ;