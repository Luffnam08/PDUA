--------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
--------------------------------------------------------------
ENTITY Adder_Substractor IS
	GENERIC(N_Bits   : INTEGER := 8);
   PORT(   x        : IN  STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
		     y        : IN  STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
		     addn_sub : IN  STD_LOGIC;
		     s        : OUT STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
           cout     : OUT STD_LOGIC);
END ENTITY Adder_Substractor;
--------------------------------------------------------------
ARCHITECTURE RTL OF Adder_Substractor IS
SIGNAL yxor            : STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
SIGNAL addn_sub_vector : STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
--------------------------------------------------------------
BEGIN
	vector_generation: FOR i IN N_Bits-1 DOWNTO 0 GENERATE
		addn_sub_vector(i) <= addn_sub;
	END GENERATE;
--------------------------------------------------------------
	yxor <= y XOR addn_sub_vector;
	Adder: ENTITY WORK.N_Bit_Adder
	GENERIC MAP (N_Bits => N_Bits)
	PORT MAP(    x      => x,
	             y      => yxor,
					 cin    => addn_sub,
					 s      => s,
					 cout   => cout);
END ARCHITECTURE RTL;
--------------------------------------------------------------