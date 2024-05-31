----------------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
----------------------------------------------------------------------------------------
ENTITY Shift_Unit IS
	GENERIC(N_Bits  : INTEGER :=8);
	PORT (  shamt   : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
           dataa   : IN  STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
           dataout : OUT STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0));
END ENTITY Shift_Unit;
----------------------------------------------------------------------------------------
ARCHITECTURE RTL OF Shift_Unit IS
BEGIN
  -- Mux Ver. 1
  dataout <= dataa                        WHEN shamt = "00"  ELSE -- No shift
          '0' & dataa(N_Bits-1 DOWNTO 1)  WHEN shamt = "01"  ELSE -- srl
          dataa (N_Bits-2 DOWNTO 0) & '0' WHEN shamt = "10"  ELSE -- sll
          (OTHERS => '0');                                        -- NU, fill with zeros
END ARCHITECTURE RTL;
----------------------------------------------------------------------------------------