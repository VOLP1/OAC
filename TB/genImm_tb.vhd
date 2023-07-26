library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity testbench is
end entity testbench;

architecture a of testbench is

component genImm32 is
port (
	   instr : in std_logic_vector(31 downto 0);
	   imm32 : out signed(31 downto 0));
end component genImm32;

signal instr: std_logic_vector(31 downto 0);
signal imm32: signed(31 downto 0);
        

begin

Aciona: process begin
  	instr <= x"00000000";  
    wait for 10 ns;
    --1 imm 000000000
    
    instr <= x"000002b3";  
    wait for 10 ns;
    --2 imm 
    
    instr <= x"01002283";  
    wait for 10 ns;
    --3 imm 
    
    instr <= x"f9c00313";  
    wait for 10 ns;
    --4 imm 
    
    instr <= x"fff2c293";  
    wait for 10 ns;
    --5 imm 
    
    instr <= x"16200313";  
    wait for 10 ns;
    --6 imm 
    
    instr <= x"01800067";  
    wait for 10 ns;
    --7 imm 
    
    instr <= x"00002437";  
    wait for 10 ns;
    --8 imm 
    
    instr <= x"02542e23";  
    wait for 10 ns;
    --9 imm 
    
    instr <= x"fe5290e3";  
    wait for 10 ns;
    --10 imm 
    
    instr <= x"00c000ef";  
    wait for 10 ns;
    --11 imm 
    
    instr <= x"00000000";  
    wait for 10 ns;
    --1 imm 000000000
    
    
	wait;
  end process;
  
DUT : entity work.genImm32
     	port map (
        instr => instr,
        imm32 => imm32);

end architecture a;
