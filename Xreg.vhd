
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity XREGS is
	generic	(WSIZE	:	natural	:=	32);
	
	port(
		wren, rst	:	in		std_logic;
		rs1, rs2, rd	:	in		std_logic_vector(4 downto 0);
		data			:	in		std_logic_vector(WSIZE-1 downto 0);
		ro1, ro2		:	out	    std_logic_vector(WSIZE-1 downto 0)
	);
end XREGS;

architecture princ of XREGS is
	
	type 	regArray is array (0 to WSIZE-1) of std_logic_vector (WSIZE-1 downto 0);
	signal	bRegs: regArray := (others => (others => '0'));
	signal	rs1i, rs2i, rdi, i:	integer;
	
	begin
	rs1i	<=	to_integer(unsigned(rs1));
	rs2i	<=	to_integer(unsigned(rs2));
	rdi	<=	to_integer(unsigned(rd));
	i <= 0;
	
	process(rs1, rs2, rd, data, wren)
	begin
		if	(rst = '1') then
			for i in 0 to WSIZE-1 loop
				bRegs(i)	<=	(bRegs(i)'range	=>	'0');
			end loop;
			ro1	<=	bRegs(0);
			ro2	<=	bRegs(0);
			
		else	
			if rs1i >= 0 then
			ro1	<=	bRegs(rs1i);
			end if;
			if rs2i >= 0 then
			ro2	<=	bRegs(rs2i);
			end if;
			if	(wren =  '1' and rdi /= 0) then
				bRegs(rdi)	<=	data;
			end if;
		end if;
		
	end process;	
end princ;
