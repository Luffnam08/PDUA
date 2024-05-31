---------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
---------------------------------------------------------------
ENTITY IR IS
	GENERIC(N_Bits  : INTEGER := 8;
	        Bits_Op : INTEGER := 5);
	PORT(   clk     : IN  STD_LOGIC;
		     rst     : IN  STD_LOGIC;
		     ena     : IN  STD_LOGIC;
	        busC    : IN  STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
		     sclr    : IN  STD_LOGIC;
		     opcode  : OUT STD_LOGIC_VECTOR(Bits_Op-1 DOWNTO 0));
END ENTITY;
---------------------------------------------------------------
ARCHITECTURE RTL OF IR IS
BEGIN
	dff: PROCESS(clk, rst, ena, busC, sclr)
	BEGIN
			IF(rst = '1') THEN
				opcode <= (OTHERS => '0');
		   ELSIF (rising_edge(clk)) THEN
				IF (sclr = '1') THEN
					opcode <= (OTHERS => '0');
				ELSIF (ena = '1') THEN 
					opcode <= busC(N_Bits-1 DOWNTO Bits_Op-2);
				END IF;
			END IF;
	END PROCESS;
END ARCHITECTURE RTL;
---------------------------------------------------------------