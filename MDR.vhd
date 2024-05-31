------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
------------------------------------------------------------------
ENTITY MDR IS
	GENERIC(N_Bits     : INTEGER := 8);
	PORT(   clk  		 : IN  STD_LOGIC;
		     rst  	    : IN  STD_LOGIC;
	        data_in    : IN  STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
           busALU 	 : IN  STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
           mdr_ena    : IN  STD_LOGIC;
           mdr_alu_no : IN  STD_LOGIC;
		     busC 		 : OUT STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
		     data_out   : OUT STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0));
END MDR;
------------------------------------------------------------------
ARCHITECTURE Behavioral OF MDR IS
BEGIN
	PROCESS(clk, rst, data_in, busALU, mdr_ena, mdr_alu_no)
	BEGIN
	IF(rst = '1') THEN
		data_out <= (OTHERS => '0'); 
		busC     <= (OTHERS => '0');
	ELSIF(RISING_EDGE(clk)) THEN
		IF(mdr_alu_no = '0') THEN
			busC <= busALU;
		ELSE 
			busC <= data_in;
		END IF;
		IF(mdr_ena = '1') THEN
			data_out <= busALU;
		ELSE
			data_out <= data_in;
		END IF;
	END IF;
	END PROCESS;
END ARCHITECTURE Behavioral;
------------------------------------------------------------------