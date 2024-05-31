-------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------
ENTITY MAR IS
	GENERIC(N_Bits : INTEGER := 8);
	PORT(clk       : IN  STD_LOGIC;
	     rst       : IN  STD_LOGIC;
		  ena       : IN  STD_LOGIC;
		  d         : IN  STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
		  q         : OUT STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0));
END ENTITY;
-------------------------------------------------------------
ARCHITECTURE RTL OF MAR IS
BEGIN
	dff: PROCESS(clk, rst, d)
	BEGIN
		IF(rst = '1') THEN
			q <= (OTHERS => '0');
		ELSIF (rising_edge(clk)) THEN
			IF (ena = '1') THEN 
				q <= d;
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE RTL;
-------------------------------------------------------------