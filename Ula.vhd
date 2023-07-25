library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ulaRiscV is

generic(WSIZE : natural := 32);
      
    
port( 
		opcode: in std_logic_vector(3 downto 0);
  		A, B : in std_logic_vector(WSIZE -1 downto 0);
 	 	Z : out std_logic_vector(WSIZE -1 downto 0);
		zero : out std_logic
);
end ulaRiscV;

architecture a of ulaRiscV is

--cte
constant ZERO32: std_logic_vector(31 downto 0) := (others => '0');
constant UM32: std_logic_vector(31 downto 0) := (0 => '1', others => '0');

signal a32: std_logic_vector(31 downto 0);

begin
  	Z <= a32;
	proc_ula: process(A, B, opcode, a32) begin
    
		if(a32 = ZERO32) then zero <= '1'; else zero <= '0'; end if;
    
		case opcode is
			when "0000" => a32 <= std_logic_vector(signed(A) + signed(B));
			when "0001" => a32 <= std_logic_vector(signed(A) - signed(B));
			when "0010" => a32 <= A AND B;
			when "0011" => a32 <= A OR B;
			when "0100" => a32 <= A XOR B;
            
			when "0101" => a32 <= std_logic_vector(shift_left(unsigned(A),to_integer(unsigned(B))));
			when "0110" => a32 <= std_logic_vector(shift_left(signed(A),to_integer(unsigned(B))));
			when "0111" => a32 <= std_logic_vector(shift_right(unsigned(A),to_integer(unsigned(B))));
           		when "1000" => a32 <=  std_logic_vector(shift_right(signed(A),to_integer(unsigned(B))));
            
            
			when "1001" => if(signed(A) < signed(B)) then a32 <= UM32; else a32 <= ZERO32; end if;
			when "1010" => if(unsigned(A) < unsigned(B)) then a32 <= UM32; else a32 <= ZERO32; end if;
			when "1011" => if(signed(A) >= signed(B)) then a32 <= UM32; else a32 <= ZERO32; end if;
			when "1100" => if(unsigned(A) >= unsigned(B)) then a32 <= UM32; else a32 <= ZERO32; end if; 
			when "1101" => if(A = B) then a32 <= UM32; else a32 <= ZERO32; end if;
			when "1110" => if(A /= B) then a32 <= UM32; else a32 <= ZERO32; end if;
			when others => a32 <= ZERO32;

		end case;
	end process;
end a;
