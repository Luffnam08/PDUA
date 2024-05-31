---------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
---------------------------------------------------------
ENTITY JMP_MUX IS
	PORT(C, N, P, Z, I : IN  STD_LOGIC;
        jcond         : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
		  load          : OUT STD_LOGIC);
END ENTITY JMP_MUX;
---------------------------------------------------------
ARCHITECTURE Behavioral OF JMP_MUX IS
---------------------------------------------------------
BEGIN
	PROCESS(C, N, P, Z, I, jcond)
	BEGIN
---------------------------------------------------------
		CASE jcond IS
			WHEN "001" =>
				load <= '1';
---------------------------------------------------------
			WHEN "010" =>
				CASE Z IS
					WHEN '0'    => load <= '0';
               WHEN OTHERS => load <= '1';
            END CASE;
---------------------------------------------------------
			WHEN "011" =>
				CASE N IS
					WHEN '0'    => load <= '0';
               WHEN OTHERS => load <= '1';
            END CASE;
---------------------------------------------------------
			WHEN "100" =>
				CASE C IS
					WHEN '0'    => load <= '0';
               WHEN OTHERS => load <= '1';
            END CASE;
---------------------------------------------------------
			WHEN "101" =>
				CASE P IS
					WHEN '0'    => load <= '0';
               WHEN OTHERS => load <= '1';
            END CASE;
---------------------------------------------------------
			WHEN "110" =>
				CASE I IS
					WHEN '0'    => load <= '0';
               WHEN OTHERS => load <= '1';
            END CASE;
---------------------------------------------------------
			WHEN OTHERS =>
				load <= '0';
		END CASE;
	END PROCESS;
---------------------------------------------------------
END ARCHITECTURE Behavioral;
---------------------------------------------------------