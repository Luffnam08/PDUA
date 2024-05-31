---------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
---------------------------------------------------------
ENTITY Splitter IS
	PORT(data_in      : IN  STD_LOGIC_VECTOR(28 DOWNTO 0); 
		  uInstruction : OUT STD_LOGIC_VECTOR(20 DOWNTO 0);
		  en_uPC       : OUT STD_LOGIC;
		  clr_uPC      : OUT STD_LOGIC;
		  jcond        : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		  offset       : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
END ENTITY Splitter;
---------------------------------------------------------
ARCHITECTURE Behavioral OF Splitter IS
BEGIN
	assign: PROCESS(data_in)
   BEGIN
        uInstruction <= data_in(28 DOWNTO 8);
		  en_uPC       <= data_in(7);
		  clr_uPC      <= data_in(6);
		  jcond        <= data_in(5 DOWNTO 3);
		  offset       <= data_in(2 DOWNTO 0);
	END PROCESS;
---------------------------------------------------------
END ARCHITECTURE Behavioral;
---------------------------------------------------------