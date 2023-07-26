-- Simple OR gate design
library IEEE;
use IEEE.std_logic_1164.all;

entity genImm32 is
port (
instr : in std_logic_vector(31 downto 0);
imm32 : out signed(31 downto 0));
end genImm32;

architecture a of genImm32 is

signal opcode : std_logic_vector(6 downto 0);
begin
opcode <= instr(6 downto 0);

case opcode is
    when 0x33 => 
        imm32 <= '0'
    when 0x03| 0x13| 0x67 =>
        imm32 <= resize(signed(inst(31 downto 20)), 32);
    when 0x23 => 
        imm32 <= resize(signed(ins(31:25) & ins(11:7)),32);
    when 0x63 => 
        imm32 <= resize(signed(ins(31) & ins(7) & ins(30:25) & ins(11:8)&'0'),32);
    when 0x37 => 
        imm32 <=  ins(31:12)& x"000"
    when 0x6F => 
        imm32 <= resize(signed(ins(31) & ins(19:12) & ins(20) & ins(30:21) & '0'),32);
        

    ...
end case;

end gemImm32;
