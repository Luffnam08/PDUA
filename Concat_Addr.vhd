---------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
---------------------------------------------------
ENTITY Concat_Addr IS
	PORT(opcode : IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
        uIn    : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
        addr   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END ENTITY Concat_Addr;
---------------------------------------------------
ARCHITECTURE Behavioral OF Concat_Addr IS
BEGIN
    addr <= opcode & uIn;
---------------------------------------------------
END ARCHITECTURE Behavioral;
---------------------------------------------------
