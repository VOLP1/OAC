-- Projeto final de OAC, Processador RISCV pipeline
-- Amanda Reis e Eduardo Volpi
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Processador is

generic(WSIZE : natural := 32);

port(
	clk: in std_logic);

end Processador;

architecture princ of Processador is

-- Declaracao dos modulos

component Ula is
	port(
		op_in: in std_logic_vector(3 downto 0);
  		A, B : in std_logic_vector(WSIZE -1 downto 0);
 	 	Z : out std_logic_vector(WSIZE -1 downto 0);
		zero : out std_logic
	);
end component;

component XREGS is
	port(
		wren, rst	:	in		std_logic;
		rs1, rs2, rd	:	in		std_logic_vector(4 downto 0);
		data			:	in		std_logic_vector(WSIZE-1 downto 0);
		ro1, ro2		:	out	    std_logic_vector(WSIZE-1 downto 0)
	);
end component;

component GenImm32 is
	port (
		instr : in std_logic_vector(31 downto 0);
		imm32 : out signed(31 downto 0)
	);
end component;

component MemInstr is
	port (
		addr 	: in	std_logic_vector(31 downto 0);
		data_out : out	std_logic_vector(31 downto 0)
	);
end component;

component MemDados is
	port (
		we 		: in	std_logic;
		addr 	: in	std_logic_vector(31 downto 0);
		data_in  : in	std_logic_vector(31 downto 0);
		data_out : out	std_logic_vector(31 downto 0)
	);
end component;

component Control is
	port (
		instr  : in std_logic_vector(31 downto 0);
		ALUOp  : out std_logic_vector(1 downto 0);
		ALUSrc, Branch, MemRead, MemWrite, RegWrite, Mem2Reg, AUIPc: out std_logic
	);
end component;

component RegFD is     
	port(
		clk : in std_logic;

		pc_in, instr_in : in std_logic_vector(WSIZE -1 downto 0);
		pc_out, instr_out : out std_logic_vector(WSIZE -1 downto 0);
		rs1_out, rs2_out, rd_out : out std_logic_vector(4 downto 0);
		ula_instr : out std_logic_vector(3 downto 0)
	);
end component;

component RegDE is
	port(
		clk : in std_logic;
		
		ALUSrc_in, wb_in, memread_in, memwrite_in, branch_in, auipc_in : in std_logic;
		ALUSrc_out, wb_out, memread_out, memwrite_out, branch_out, funct7, auipc_out : out std_logic;	
		ALUOp_in : in std_logic_vector(1 downto 0);
		ALUOp_out : out std_logic_vector(1 downto 0);
		rd_in : in std_logic_vector(4 downto 0);
		rd_out : out std_logic_vector(4 downto 0);
		imm_in : signed(31 downto 0);
		rs1_in, rs2_in, pc_in: in std_logic_vector(WSIZE -1 downto 0);
		rs1_out, rs2_out, pc_out, imm_out : out std_logic_vector(WSIZE -1 downto 0);
		ula_instr_in : in std_logic_vector(3 downto 0);
		funct3 : out std_logic_vector(2 downto 0)
	);
end component;

component RegEM is
	port(
		clk : in std_logic;
		
		wb_in, branch_in, zero_in, memread_in, memwrite_in : in std_logic;
		wb_out, branch_out, zero_out, memread_out, memwrite_out : out std_logic;
		rd_in : in std_logic_vector(4 downto 0);
		rd_out : out std_logic_vector(4 downto 0);
		rs2_in, pc_in, ula_in : in std_logic_vector(WSIZE -1 downto 0);
		rs2_out, pc_out, ula_out : out std_logic_vector(WSIZE -1 downto 0)
	);
end component;

component RegMW is    
	port(
		clk : in std_logic;
		
		wb_in, memread_in : in std_logic;
		wb_out, memread_out : out std_logic;
		rd_in : in std_logic_vector(4 downto 0);
		rd_out : out std_logic_vector(4 downto 0);
		ula_in, memo_data_in : in std_logic_vector(WSIZE -1 downto 0);
		ula_out, memo_data_out : out std_logic_vector(WSIZE -1 downto 0)
	);
end component;

component AddPC is

	port(
		A : in std_logic_vector(31 downto 0);
		Z : out std_logic_vector(31 downto 0)
	);

end component;

component PortaAnd is

	port(
		A : in std_logic;
		B : in std_logic;
		Y : out std_logic
	);

end component;

component Add is

	port(
		pc_in, imm : in std_logic_vector(31 downto 0);
		pc_out : out std_logic_vector(31 downto 0)
	);

end component;

component Mux is 
	port (
		a, b : in std_logic_vector(WSIZE-1 downto 0);
		ctrl : in std_logic;
		z : out std_logic_vector(WSIZE-1 downto 0)
	);
end component;

component PC is
	port(
		clk : in std_logic;
		
		pc_in : in std_logic_vector(WSIZE -1 downto 0);
		pc_out : out std_logic_vector(WSIZE -1 downto 0)
	);
end component;

component ControlUla is
	port (
		ALUOp : in std_logic_vector(1 downto 0);
		funct7 : in std_logic;
		auipcIn : in std_logic;
		funct3 : in std_logic_vector(2 downto 0);
		opOut : out std_logic_vector(3 downto 0)
	);
end component;

-- "Jumpers"
-- x_we, x_rst,
signal sclk, zero_ex, ex_ALUSrc, RegWrite, MemWrite, Mem2Reg, ex_funct7, ex_auipc, gnd : std_logic;
signal ex_branch, ex_wb, mem_branch, mem_zero, PCSrc, ex_memread, auipc_id : std_logic;
signal ALUSrc_id, branch_id, memread_id, memwrite_id, wb_id, id_auipc, ex_memwrite : std_logic;
signal memo_wb, mem_memread, mem_memwrite : std_logic;
signal ula_command, ula_instr_id : std_logic_vector(3 downto 0);
signal id_rs1, id_rs2, WriteReg, rd_id, ex_rd, mem_rd : std_logic_vector(4 downto 0);
signal mem_addr : std_logic_vector(7 downto 0);
signal xreg_out1, xreg_out2, xreg_in, ula_in1, ula_in2, ula_out, ex_imm, mem_pc, pc_in : std_logic_vector(WSIZE-1 downto 0);
signal id_instr, if_instr, mem_out, mem_in, ula_ex, instr_if, id_pc, pc_ex: std_logic_vector(WSIZE-1 downto 0);
signal rs1_id, rs2_id, pc_out, mem_ula, mem_rs2, memo_data_mem, WriteData, pc_if, pc_4 : std_logic_vector(WSIZE-1 downto 0);
signal ex_rs2, ex_rs1, ex_pc, wb_memo_data, wb_ula, pc_id : std_logic_vector(WSIZE-1 downto 0);
signal imm_id : signed(31 downto 0);
signal ALUOp_id, ex_ALUOp : std_logic_vector(1 downto 0);
signal ex_funct3 : std_logic_vector(2 downto 0);


-- Ligacao entre modulos
begin
gnd <= '0';

sclk <= clk;

--Fetch
mux_pc: Mux port map(
	a => pc_4,
	b => mem_pc,
	ctrl => PCSrc,
	z => pc_in
);
reg_pc: PC port map(
	clk => sclk,
	pc_in => pc_in,
	pc_out => pc_out
);
add_Pc: AddPC port map(
	A => pc_out,
	Z => pc_4
);
code_mem: MemInstr port map(
	addr =>	pc_out,
	data_out => instr_if
);
reg_if_id: RegFD port map(
	clk => sclk,		
	pc_in => pc_out,
	instr_in => instr_if,
	pc_out => pc_id,
	instr_out => id_instr,
	rd_out => rd_id,
	ula_instr => ula_instr_id,
	rs1_out => id_rs1,
	rs2_out => id_rs2
);


--Decode
xreg: XREGS port map(
	wren => RegWrite,
	rst => gnd,
	rs1 => id_rs1,
	rs2 => id_rs2,
	rd => WriteReg,
	data => WriteData,
	ro1 => rs1_id,
	ro2 => rs2_id
);
imm: GenImm32 port map(
	instr => id_instr,
	imm32 => imm_id
);
ctrl: Control port map(
	instr  => id_instr,
	ALUOp  => ALUOp_id,
	ALUSrc => ALUSrc_id,
	Branch => branch_id,
	MemRead => open,
	MemWrite => memwrite_id,
	RegWrite => wb_id,
	Mem2Reg => memread_id,
	AUIPc => auipc_id
);--memread_id -> mem2reg
reg_id_ex: RegDE port map(
	clk => sclk,		
	wb_in => wb_id,
	branch_in => branch_id,
	wb_out => ex_wb,
	branch_out => ex_branch,
	rd_in => rd_id,
	rd_out => ex_rd,
	rs1_in => rs1_id,
	rs2_in => rs2_id,
	pc_in => pc_id,
	imm_in => imm_id,
	rs1_out => ex_rs1,
	rs2_out => ex_rs2,
	pc_out => ex_pc,
	imm_out => ex_imm,
	ula_instr_in => ula_instr_id,
	ALUOp_in => ALUOp_id,
	ALUOp_out => ex_ALUOp,
	ALUSrc_in => ALUSrc_id,
	ALUSrc_out => ex_ALUSrc,
	memread_in => memread_id,
	memread_out => ex_memread,
	memwrite_in => memwrite_id,
	memwrite_out => ex_memwrite,
	funct7 => ex_funct7,
	funct3 => ex_funct3,
	auipc_in => auipc_id,
	auipc_out => ex_auipc
);-->memread_in --> mem2reg


--Execute
addSum: Add port map(
	pc_in => ex_pc,
	imm => ex_imm,
	pc_out => pc_ex
);
mux_ula: Mux port map(
	a => ex_rs2,
	b => ex_imm,
	ctrl => ex_ALUSrc,
	z => ula_in2
);
ula_riscV: Ula port map(
	op_in => ula_command,
	A => ex_rs1,
	B => ula_in2,
	Z => ula_ex,
	zero => zero_ex
);
ula_ctrl: ControlUla port map(
	ALUOp => ex_ALUOp,
	funct7 => ex_funct7,
	auipcIn => ex_auipc,
	funct3 => ex_funct3,
	opOut => ula_command
);
reg_ex_mem: RegEM port map(
	clk => sclk,		
	wb_in => ex_wb,
	branch_in => ex_branch,
	zero_in => zero_ex,
	wb_out => memo_wb,
	branch_out => mem_branch,
	zero_out => mem_zero,
	rd_in => ex_rd,
	rd_out => mem_rd,
	rs2_in => ex_rs2,
	pc_in => pc_ex,
	ula_in => ula_ex,
	rs2_out => mem_rs2,
	pc_out => mem_pc,
	ula_out => mem_ula,
	memread_in => ex_memread,
	memread_out => mem_memread,
	memwrite_in => ex_memwrite,
	memwrite_out => mem_memwrite
);


--Memory
branch_and: PortaAnd port map(
	A => mem_branch,
	B => mem_zero,
	Y => PCSrc
);
data_mem: MemDados port map(
	we => mem_memwrite,
	addr => mem_ula,
	data_in => mem_rs2,
	data_out => memo_data_mem
);
reg_mem_wb: RegMW port map(
	clk => sclk,		
	wb_in => memo_wb,
	wb_out => RegWrite,
	rd_in => mem_rd,
	rd_out => WriteReg,
	ula_in => mem_ula,
	memo_data_in => memo_data_mem,
	ula_out => wb_ula,
	memo_data_out => wb_memo_data,
	memread_in => mem_memread,
	memread_out => Mem2Reg
);


--Write Back
mux_wb: Mux port map(
	a => wb_ula,
	b => wb_memo_data,
	ctrl => Mem2Reg,
	z => WriteData
);

end princ;