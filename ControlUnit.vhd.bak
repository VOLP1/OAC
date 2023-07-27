library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Control is
	port (
		instr  : in std_logic_vector(31 downto 0);
		ALUOp  : out std_logic_vector(1 downto 0);
		ALUSrc, AUIPC, Branch, MemRead, MemWrite, RegWrite, Mem2Reg: out std_logic
	);
            
end Control;

architecture princ of Control is
	signal opcode : std_logic_vector(7 downto 0);

begin 
	opcode <= '0' & instr(6 downto 0);
    
    process (opcode) begin
    
    case opcode is
    	when x"33" => --Tipo R
	    ALUOp  <= "10";
            ALUSrc <= '0';
            Branch <= '0';
            MemRead <= '0';
            MemWrite <= '0';
            RegWrite <= '1';
            Mem2Reg <= '0';
            AUIPc <= '0';
            
	when x"03" => -- Tipo I (LW)
            ALUOp  <= "00";
            ALUSrc <= '1';
            Branch <= '0';
            MemRead <= '1';
            MemWrite <= '0';
            RegWrite <= '1';
            Mem2Reg <= '1';
            AUIPc <= '0';
            
        when x"13" => -- Tipo I (LA com imm) 
        	ALUOp  <= "10";
            ALUSrc <= '1';
            Branch <= '0';
            MemRead <= '0';
            MemWrite <= '0';
            RegWrite <= '1';
            Mem2Reg <= '0';
            AUIPc <= '0';
            
        when x"67" => -- Tipo I (jalr)  ???
            ALUOp  <= "10";
            ALUSrc <= '1';
            Branch <= '0';
            MemRead <= '0';
            MemWrite <= '0';
            RegWrite <= '1';
            Mem2Reg <= '0';
            
	when x"23" => -- Tipo S (sb)
            ALUOp  <= "00";
            ALUSrc <= '1';
            Branch <= '0';
            MemRead <= '0';
            MemWrite <= '1';
            RegWrite <= '0';
            AUIPc <= '0';
            
        when x"37"| x"17" => -- Tipo U (LUI e AUIPC) 
	    ALUOp  <= "10";
            ALUSrc <= '1';
            Branch <= '0';
            MemRead <= '0';
            MemWrite <= '0';
            RegWrite <= '1';
            Mem2Reg <= '1';
            AUIPc <= '1';
            
            
	when x"63" => -- Tipo B (branchs)
            ALUOp  <= "01";
            ALUSrc <= '0';
            Branch <= '1';
            MemRead <= '0';
            MemWrite <= '0';
            RegWrite <= '0';
            AUIPc <= '0';
              
        when x"6F" => -- Tipo I (jal) ???
            ALUOp  <= "10";
            ALUSrc <= '1';
            Branch <= '1';
            MemRead <= '0';
            MemWrite <= '0';
            RegWrite <= '1';
            Mem2Reg <= '0';
            AUIPc <= '0';
        
	when others => --  Outras ???
       	    ALUOp  <= "00";
            ALUSrc <= '0';
            Branch <= '0';
            MemRead <= '0';
            MemWrite <= '0';
            RegWrite <= '0';
            Mem2Reg <= '0';
            AUIPc <= '0';
      end case;
    end process;
end;