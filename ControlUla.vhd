library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;


ENTITY Control_ALU IS
  GENERIC (WSIZE : natural := 32);
  PORT (
    ALUOp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    funct7 : IN STD_LOGIC;
    auipcIn : IN STD_LOGIC;
    funct3 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    opOut : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END ENTITY control_alu;

ARCHITECTURE princ OF Control_ALU IS

BEGIN

  PROCESS (funct7, funct3, ALUOp, auipcIn)
  BEGIN

    CASE ALUOp IS

      WHEN "00" =>
        CASE funct3 IS
          WHEN "000" =>
            IF funct7 = '0' THEN
              opOut <= "0000";  -- ADD
            ELSE
              opOut <= "0001";  -- SUB
            END IF;
          WHEN "001" => opOut <= "0101";  -- SLL
          WHEN "010" => opOut <= "1000";  -- SLT
          WHEN "011" => opOut <= "1001";  -- SLTU
          WHEN "100" => opOut <= "0100";  -- XOR
          WHEN "101" =>
            IF funct7 = '0' THEN
              opOut <= "0110";  -- SRL
            ELSE
              opOut <= "0111";  -- SRA
            END IF;
          WHEN "110" => opOut <= "0011";  -- OR
          WHEN "111" => opOut <= "0010";  -- AND
          WHEN OTHERS => opOut <= "0000";
        END CASE;
      WHEN "01" =>
        CASE funct3 IS
          WHEN "000" => opOut <= "0000";  -- ADDi
          WHEN "001" => opOut <= "0101";  -- SLLi
          WHEN "010" => opOut <= "1000";  -- SLTi
          WHEN "011" => opOut <= "1001";  -- SLTUi
          WHEN "100" => opOut <= "0100";  -- XORi
          WHEN "101" =>
            IF funct7 = '0' THEN
              opOut <= "0110";  -- SRLi
            ELSE
              opOut <= "0111";  -- SRAi
            END IF;
          WHEN "110" => opOut <= "0011";  -- ORi
          WHEN "111" => opOut <= "0010";  -- ANDi
          WHEN OTHERS => opOut <= "0000";
        END CASE;
      WHEN "10" =>
        CASE funct3 IS
          WHEN "000" => opOut <= "1100";  -- BEQ
          WHEN "001" => opOut <= "1101";  -- BNE
          WHEN "100" => opOut <= "1000";  -- BLT
          WHEN "101" => opOut <= "1010";  -- BGE
          WHEN "110" => opOut <= "1001";  -- BLTU
          WHEN "111" => opOut <= "1011";  -- BGEU
          WHEN OTHERS => opOut <= "0000";
        END CASE;
      WHEN "11" =>
        IF auipcIn = '0' THEN
          opOut <= "1110";  -- LUi (e AUIPC)
        ELSE
          opOut <= "1111";  -- JAL
        END IF;
      WHEN OTHERS => opOut <= "0000";

    END CASE;

  END PROCESS;

END;