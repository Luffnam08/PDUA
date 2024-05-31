------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
------------------------------------------------------
ENTITY Full_Adder_C IS
   PORT(x    : IN  STD_LOGIC := '0';
		  y    : IN  STD_LOGIC := '0';
		  cin  : IN  STD_LOGIC;
		  s    : OUT STD_LOGIC;
        cout : OUT STD_LOGIC);
END ENTITY Full_Adder_C;
------------------------------------------------------
ARCHITECTURE Gate_Level OF Full_Adder_C IS
	BEGIN
		s    <=  x XOR y XOR cin;
		cout <= (x AND y) OR (x AND cin) OR (y AND cin);
END ARCHITECTURE Gate_Level;
------------------------------------------------------