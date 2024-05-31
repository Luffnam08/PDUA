--------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
--------------------------------------------------------------
ENTITY uPC IS
	GENERIC(N_Bits  : INTEGER := 3);
   PORT(	  clk     : IN  STD_LOGIC;
		     rst     : IN  STD_LOGIC;
		     en_uPC  : IN  STD_LOGIC;
		     clr_uPC : IN  STD_LOGIC;
		     d       : IN  STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
		     q       : OUT STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0));
END ENTITY uPC;	
--------------------------------------------------------------
ARCHITECTURE RTL OF uPC IS
--------------------------------------------------------------
BEGIN
	dff: PROCESS(clk, rst, d)
	BEGIN 
		IF(rst = '1') THEN
			q <= (OTHERS => '0');
		ELSIF (RISING_EDGE(clk)) THEN
			IF (clr_uPC ='1') THEN
				q <= (OTHERS => '0');
			ELSIF (en_uPC = '1') THEN 
				q <= d;
			END IF;
		END IF;
	END PROCESS;
--------------------------------------------------------------
END ARCHITECTURE RTL;
--------------------------------------------------------------