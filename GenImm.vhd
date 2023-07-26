library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity genImm32 is
port (
instr : in std_logic_vector(31 downto 0);
imm32 : out signed(31 downto 0));
end genImm32;

architecture princ of genImm32 is

signal opcode : std_logic_vector(7 downto 0);
begin
opcode <= '0' & instr(6 downto 0);

 with opcode select
        imm32 <= x"00000000" when x"33",
        resize(signed(instr(31 downto 20)), 32) when x"03"|x"13"|x"67",
        resize(signed(instr(31 downto 25) & instr(11 downto 7)),32) when x"23",
        resize(signed(instr(31) & instr(7) & instr(30 downto 25) & instr(11 downto 8)&'0'),32)  when x"63",
        resize(signed(instr(31 downto 12) & x"000"),32) when x"37",
        resize(signed(instr(31) & instr(19 downto 12) & instr(20) & instr(30 downto 21) & '0'),32)  when x"6F",
        x"00000000" when others;
end princ;