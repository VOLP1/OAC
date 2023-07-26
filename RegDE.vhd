
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity DE is

generic(WSIZE : natural := 32);      
    
port(
	clk : in std_logic;
	ALUSrc_in, wb_in, memread_in, memwrite_in, branch_in, auipc_in : in std_logic;
	ALUSrc_out, wb_out, memread_out, memwrite_out, branch_out, funct7, auipc_out : out std_logic;	
	ALUOp_in : in std_logic_vector(1 downto 0);
	ALUOp_out : out std_logic_vector(1 downto 0);
	rd_in : in std_logic_vector(4 downto 0);
	rd_out : out std_logic_vector(4 downto 0);
	imm_in : signed(31 downto 0);
	rs1_in, rs2_in, pc_in : in std_logic_vector(WSIZE -1 downto 0);
	rs1_out, rs2_out, pc_out, imm_out : out std_logic_vector(WSIZE -1 downto 0);
	ula_instr_in : in std_logic_vector(3 downto 0);
	funct3 : out std_logic_vector(2 downto 0)
);
end DE;

architecture princ of DE is

begin

process(clk) begin

	if rising_edge(clk) then
		wb_out <= wb_in;
		memread_out <= memread_in;
		memwrite_out <= memwrite_in;
		branch_out <= branch_in;
		rd_out <= rd_in;
		rs1_out <= rs1_in;
		rs2_out <= rs2_in;
		pc_out <= pc_in;
		imm_out <= std_logic_vector(imm_in);
		ALUOp_out <= ALUOp_in;
		ALUSrc_out <= ALUSrc_in;
		funct7 <= ula_instr_in(3);
		funct3 <= ula_instr_in(2 downto 0);
		auipc_out <= auipc_in;
	
	
	end if;

end process;

end princ;