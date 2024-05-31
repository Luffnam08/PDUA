-------------------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------------------------------
ENTITY N_Bit_Adder_C IS
	GENERIC(N_Bits : INTEGER := 3);
   PORT(   x      : IN  STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
		     y      : IN  STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
		     cin    : IN  STD_LOGIC;
		     s      : OUT STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
           cout   : OUT STD_LOGIC);
END ENTITY N_Bit_Adder_C;
-------------------------------------------------------------------------------------------
ARCHITECTURE RTL OF N_Bit_Adder_c IS
SIGNAL carry: STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
-------------------------------------------------------------------------------------------
BEGIN
	Adder: FOR i IN N_Bits-1 DOWNTO 0 GENERATE
		BIT0: IF i=0 GENERATE
					B0: ENTITY WORK.Full_Adder_C PORT MAP(x(i), y(i), cin, s(i), carry(i));
			   END GENERATE;
		BITN: IF i /= 0 GENERATE
					BN: ENTITY WORK.Full_Adder_C PORT MAP(x(i), y(i), carry(i-1), s(i), carry(i));
			   END GENERATE;
	END GENERATE;
-------------------------------------------------------------------------------------------
	cout <= carry(carry'LEFT);	
END ARCHITECTURE RTL;
-------------------------------------------------------------------------------------------