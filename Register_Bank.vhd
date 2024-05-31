------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
------------------------------------------------------------------------------
ENTITY Register_Bank IS 
	GENERIC( N_Bits      : INTEGER := 8;
	         ADDR_WIDTH  : INTEGER := 3);
	PORT(    clk         : IN  STD_LOGIC;
	         rst         : IN  STD_LOGIC;
				wr_en		   : IN  STD_LOGIC;
				w_addr	   : IN  STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0);
				r_addr	   : IN  STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0);
				bank_w_data : IN  STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
				busA   	   : OUT STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
				busB   	   : OUT STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0));
END ENTITY;
------------------------------------------------------------------------------
ARCHITECTURE RTL OF Register_Bank IS
TYPE mem_type IS ARRAY (0 TO N_Bits-1) OF STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
SIGNAL array_reg: mem_type;
------------------------------------------------------------------------------
BEGIN
	write_process: PROCESS(clk, rst)
	BEGIN
		IF (rst = '1') THEN
			array_reg(0) <=  x"00"; -- PC
			array_reg(1) <=  x"FF"; -- SP
			array_reg(2) <=  x"00"; -- DPTR
			array_reg(3) <=  x"00"; -- A
			array_reg(4) <=  x"00"; -- AVI
			array_reg(5) <=  x"00"; -- TEMP 
			array_reg(6) <=  x"FF"; -- -1
			array_reg(7) <=  x"00"; -- ACC
		ELSIF (RISING_EDGE(clk)) THEN
			IF (wr_en = '1') THEN
				array_reg(to_integer(unsigned(w_addr)))<= bank_w_data;
			END IF;
		END IF;
	END PROCESS;
------------------------------------------------------------------------------	
	busA <= array_reg(7);
	busB <= array_reg(to_integer(unsigned(r_addr)));
END ARCHITECTURE RTL;
------------------------------------------------------------------------------