-----------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-----------------------------------------------------------------------
ENTITY Adder_Substractor_C IS
	GENERIC(N_Bits   : INTEGER := 3);
   PORT(   dataa    : IN  STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0) := "000";
		     result   : OUT STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
           cout     : OUT STD_LOGIC);
END ENTITY Adder_Substractor_C;
-----------------------------------------------------------------------
ARCHITECTURE RTL OF Adder_Substractor_C IS
SIGNAL yxor            : STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0) := "000";
SIGNAL addn_sub_vector : STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
SIGNAL datab           : STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0) := "001";
SIGNAL addn_sub        : STD_LOGIC := '0';
SIGNAL NA              : STD_LOGIC := '0';
-----------------------------------------------------------------------
BEGIN
	vector_generation: FOR i IN N_Bits-1 DOWNTO 0 GENERATE
		addn_sub_vector(i) <= addn_sub;
	END GENERATE;
-----------------------------------------------------------------------
	yxor <= datab XOR addn_sub_vector;
	Adder: ENTITY WORK.N_Bit_Adder_C
	GENERIC MAP (N_Bits => N_Bits)
	PORT MAP(    x      => dataa,
	             y      => yxor,
					 cin    => NA,
					 s      => result,
					 cout   => cout);
-----------------------------------------------------------------------
END ARCHITECTURE RTL;
-----------------------------------------------------------------------