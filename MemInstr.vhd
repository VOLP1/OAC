
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_textio.all;
use std.textio.all;

entity Code_Mem_RV is
	port (
		--clk 	: in	std_logic;
		addr 	: in	std_logic_vector(31 downto 0);
		data_out : out	std_logic_vector(31 downto 0)
	);
end entity;

architecture princ of Code_Mem_RV is
  Type mem_type is array (0 to (2**16)-1) of std_logic_vector(31 downto 0);

  signal read_addr: std_logic_vector(31 downto 0);

  constant LIMIT : integer := 16#2000#;

  impure function init_mem return mem_type is
	  file text_file	:	text open read_mode is "C:/Users/thiag/OneDrive/Documentos/Facul/OAC/Code/Processador_RiscV/Risc_V/code.txt"; -- Mudar diret�rio
	  --file data_file	:	text open read_mode is "C:/Users/thiag/OneDrive/Documentos/Facul/OAC/Code/Processador_RiscV/Memory_RiscV/data.txt"; -- Mudar diret�rio
	
	  variable text_line	:	line;
	  variable text_word	:	std_logic_vector(31 downto 0);
	  variable memoria	:	mem_type;
	  variable n		:	integer;

  begin
	  n	:=	0;
	  while not endfile(text_file) and (n*4)< LIMIT loop
		  readline(text_file, text_line);
		  hread(text_line, text_word);
		  memoria(n)	:=	text_word;
		  n	:=	n+1;
	  end loop;
	
  return memoria;
  end;

  signal mem: mem_type := init_mem;

  begin
      --process(clk) begin
	  process begin
		  read_addr <= addr;
		
		  if (to_integer(unsigned(read_addr)) < LIMIT) then
			  data_out <= mem(to_integer(unsigned(read_addr))/4);
		  end if;

	end process;
end architecture;