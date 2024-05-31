----------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
----------------------------------------------------
ENTITY uMUX IS
	PORT(rst     : IN  STD_LOGIC;
		  load    : IN  STD_LOGIC;
		  offset  : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
		  result  : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
		  uresult : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
END ENTITY uMUX;
----------------------------------------------------
ARCHITECTURE Behavioral OF uMUX IS
BEGIN
	dff: PROCESS(rst, load, offset, result)
	BEGIN
		IF(rst = '1') THEN
			uresult <= (OTHERS => '0');
		ELSIF (load = '0') THEN
			uresult <= result;
		ELSE
			uresult <= offset;
		END IF;
	END PROCESS;
----------------------------------------------------
END ARCHITECTURE Behavioral;
----------------------------------------------------