-------------------------------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
-------------------------------------------------------------------------------------------------------
ENTITY RAM IS
	GENERIC(N_Bits     : INTEGER := 8);
	PORT(   clk        : IN  STD_LOGIC;
			  rst        : IN  STD_LOGIC;
			  wr_rdn     : IN  STD_LOGIC;
			  addr       : IN  STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
			  ram_w_data : IN  STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
			  r_data     : OUT STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0));
END ENTITY;
-------------------------------------------------------------------------------------------------------
ARCHITECTURE RTL OF RAM IS
TYPE mem_type IS ARRAY (0 TO 2**N_Bits-1) OF STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
SIGNAL ram : mem_type := (
0  => x"18", 1  => x"9F", 2  => x"10", 3  => x"38", 4  => x"B0", 5  => x"A0", 6  => x"98", 7  => x"90",
8  => x"B8", 9  => x"C0", 10 => x"A8", 11 => x"48", 12 => x"40", 13 => x"08", 14 => x"D0", 15 => x"C8",
16 => x"80", 17 => x"1F", 18 => x"20", 19 => x"88", 20 => x"28", 21 => x"30", 22 => x"D8", 23 => x"FF",
31 => x"66", OTHERS => x"00");
-------------------------------------------------------------------------------------------------------
BEGIN
	write_process: PROCESS(clk)
	BEGIN	
		IF (RISING_EDGE(clk)) THEN	
			IF (wr_rdn = '1')  THEN
				ram(TO_INTEGER(UNSIGNED(addr)))<= ram_w_data;
			END IF;
		END IF;
	END PROCESS;
	r_data <= ram(TO_INTEGER(UNSIGNED(addr)));
END ARCHITECTURE RTL;
-------------------------------------------------------------------------------------------------------