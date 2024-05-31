----------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
----------------------------------------------------------------
ENTITY ALU IS
	GENERIC(N_Bits     : INTEGER := 8);
   PORT(   clk        : IN  STD_LOGIC;
           rst        : IN  STD_LOGIC;
           busA       : IN  STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
           busB       : IN  STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
           selop      : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
           shamt      : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
           enaf       : IN  STD_LOGIC;
           busC       : OUT STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
           C, N, P, Z : BUFFER STD_LOGIC);
END ENTITY ALU;
----------------------------------------------------------------
ARCHITECTURE Behavioral OF ALU IS
SIGNAL result_internal : STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
SIGNAL C_internal      : STD_LOGIC;
----------------------------------------------------------------
BEGIN
	To_Shift_Unit: ENTITY work.Shift_Unit
	PORT MAP(shamt   => shamt,
            dataa   => result_internal,
            dataout => busC);
----------------------------------------------------------------
	To_Processing_Unit: ENTITY work.Processing_Unit
	PORT MAP(dataa  => busA,
            datab  => busB,
            selop  => selop,
            result => result_internal,
            cout   => C_internal);
----------------------------------------------------------------
	To_Flag_Register: ENTITY work.Flag_Register
	PORT MAP(clk    => clk,
            rst    => rst,
            enaf   => enaf,
            dataa  => result_internal,
            carry  => C_internal,
            C      => C,
            N      => N,
            Z      => Z,
            P      => P);
END ARCHITECTURE Behavioral;
----------------------------------------------------------------