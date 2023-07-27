
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_textio.all;
use std.textio.all;

entity MemDados is
	port (
		we 		: in	std_logic;
		addr 	: in	std_logic_vector(31 downto 0);
		data_in  : in	std_logic_vector(31 downto 0);
		data_out : out	std_logic_vector(31 downto 0));
end entity;

architecture princ of MemDados is

Type mem_type is array (0 to (2**16)-1) of std_logic_vector(31 downto 0);

signal addrdado: integer;

constant LIMIT : integer := 16#2000#;

impure function init_mem return mem_type is
	file data_file	:	text open read_mode is "C:\Users\manda\Documents\UnB\Semestre 7 (2023.1)(prim sem 2023)\Organização e Arquitetura de Computadores\Processador Risc-V\OAC\TB\dataoac.txt"; -- Mudar diret�rio
	
	variable text_line	:	line;
	variable text_word	:	std_logic_vector(31 downto 0);
	variable memoria	:	mem_type;
	variable n		:	integer;

begin
	n	:=	0;
	
	while not endfile(data_file) and(n*4) < LIMIT loop
		readline(data_file, text_line);
		hread(text_line, text_word);
		memoria(n)	:=	text_word;
		n	:=	n+1;
	end loop;
return memoria;
end;

signal mem: mem_type := init_mem;

begin
	process begin
		addrdado <= to_integer(unsigned(addr))-8192;
		if we = '1' and (addrdado < LIMIT) then
			mem(addrdado/4) <= data_in;
		end if;
		
		if (addrdado < LIMIT) then
			data_out <= mem(addrdado/4);
		end if;
	end process;
end architecture;