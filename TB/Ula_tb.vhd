library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
 
entity ula_tb is
	generic(WSIZE : natural := 32);
end entity;

architecture tb_arch of ula_tb is

component ulaRiscV is
	port( 
		opcode: in std_logic_vector(3 downto 0);
  		A,B : in std_logic_vector(WSIZE -1 downto 0);
 	 	Z : out std_logic_vector(WSIZE -1 downto 0);
		zero : out std_logic
);
end component;

signal opcode: std_logic_vector(3 downto 0);
signal A, B: std_logic_vector(WSIZE -1 downto 0);
signal Z: std_logic_vector(WSIZE -1 downto 0);


begin

dut: ulaRiscV port map(
		opcode => opcode,
      A => A,
  		B => B,
  		Z => Z
);
 
drive: process begin
	--ADD
	opcode <= "0000";
    A <= x"00000002";
    B <= x"00000008";
    wait for 5 ns;
    
	 assert Z = x"0000000A" report "Soma Incorreta" severity error;
    wait for 5 ns;
    
    --SUB
    opcode <= "0001";
    A <= x"0000000F";
    B <= x"0000000A";
    wait for 5 ns;
    assert Z = x"00000005" report "Subtracao Incorreta" severity error;
    wait for 5 ns;
    
    --AND
    opcode <= "0010";
    A <= x"00000002";
    B <= x"00000003";
    wait for 5 ns;
    assert Z = (A AND B) report "AND Incorreta" severity error;
    wait for 5 ns;
    
    --OR
    opcode <= "0011";
    A <= x"00000008";
    B <= x"00000003";
    wait for 5 ns;
    assert Z = (A OR B) report "OR Incorreta" severity error;
    --report To_string(Signed(Z));
    wait for 5 ns;
    
    --XOR
    opcode <= "0100";
    A <= x"00000008";
    B <= x"00000003";
    wait for 5 ns;
    assert Z = (A XOR B) report "XOR Incorreta" severity error;
    wait for 5 ns;
    
    --SLL
    opcode <= "0101";
    A <= x"00000001";
    B <= x"00000003";
    wait for 5 ns;
    assert Z = x"00000008" report "SLLA Incorreta" severity error;
    wait for 5 ns;
    
    --SLA
    opcode <= "0110";
    A <= x"00000001";
    B <= x"00000003";
    wait for 5 ns;
    assert Z = x"00000008" report "SLA Incorreta" severity error;
    wait for 5 ns;
    
    --SRL
    opcode <= "0111";
    A <= x"80000000";
    B <= x"00000003";
    wait for 5 ns;
    assert Z = x"10000000" report "SRL Incorreta" severity error;
    wait for 5 ns;
    
    --SRA
    opcode <= "1000";
    A <= x"80000000";
    B <= x"00000003";
    wait for 5 ns;
    assert Z = x"F0000000" report "SRA Incorreta" severity error;
    wait for 5 ns;
    
    --SLT
    opcode <= "1001";
    A <= x"F0000000";
    B <= x"00000010";
    wait for 5 ns;
    assert Z = x"00000001" report "SLT Incorreta" severity error;
    wait for 5 ns;
    
    --SLTU
    opcode <= "1010";
    A <= x"F0000000";
    B <= x"00000010";
    wait for 5 ns;
    assert Z = x"00000000" report "SLTU Incorreta" severity error;
    wait for 5 ns;
    
    --SGE
    opcode <= "1011";
    A <= x"F0000000";
    B <= x"00000010";
    wait for 5 ns;
    assert Z = x"00000000" report "SGE Incorreta" severity error;
    wait for 5 ns;
    
    --SGEU
    opcode <= "1100";
    A <= x"60000000";
    B <= x"00000050";
    wait for 5 ns;
    assert Z = x"00000001" report "SGEU Incorreta" severity error;
    wait for 5 ns;
    
    --SEQ
    opcode <= "1101";
    A <= x"50000000";
    B <= x"50000000";
    wait for 5 ns;
    assert Z = x"00000001" report "SEQ Incorreta" severity error;
    wait for 5 ns;
    
    --SNE
     opcode <= "1110";
    A <= x"00003000";
    B <= x"00700000";
    wait for 5 ns;
    assert Z = x"00000001" report "SNE Incorreta" severity error;
    wait for 5 ns;
    
    opcode <= "1111";
    A <= x"00000000";
    B <= x"00000000";
    wait for 5 ns;
    assert Z = x"00000000" report "SNE Incorreta" severity error;
    wait for 5 ns;
    
    
  wait;  
end process;

end tb_arch;
