-------------------------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
-------------------------------------------------------------------------------------------------
ENTITY Processing_Unit is
	GENERIC(N_Bits : INTEGER :=8);
   PORT(   dataa  : IN  STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
		     datab  : IN  STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
		     selop	: IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
		     result : OUT STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
           cout 	: OUT STD_LOGIC);
END ENTITY Processing_Unit;	
-------------------------------------------------------------------------------------------------
ARCHITECTURE RTL OF Processing_Unit IS
CONSTANT ONE   : STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0) := STD_LOGIC_VECTOR(TO_UNSIGNED(1, N_Bits));
CONSTANT ZEROS : STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0) := (OTHERS => '0');
-------------------------------------------------------------------------------------------------
SIGNAL not_b      : STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
SIGNAL a_and_b    : STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
SIGNAL a_or_b     : STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
SIGNAL a_xor_b    : STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
SIGNAL a_plus_b   : STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
SIGNAL b_plus_one : STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
SIGNAL neg_b      : STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
SIGNAL c_sel      : STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL c_add      : STD_LOGIC;
SIGNAL c_plus1    : STD_LOGIC;
SIGNAL c_negb     : STD_LOGIC;
-------------------------------------------------------------------------------------------------
BEGIN
   not_b   <= NOT (datab);
   a_and_b <= dataa AND datab;
   a_or_b  <= dataa OR datab;
	a_xor_b <= dataa XOR datab;
-------------------------------------------------------------------------------------------------
   aplusb: ENTITY work.Adder_Substractor
	GENERIC MAP(N_Bits   => N_Bits)
	PORT MAP(   x			=> dataa,
					y			=> datab,
					addn_sub => '0',
					s			=> a_plus_b,
					cout		=> c_add);	
-------------------------------------------------------------------------------------------------
	bplusone: ENTITY work.Adder_Substractor
	GENERIC MAP(N_Bits   => N_Bits)
	PORT MAP(   x	      => datab,
	            y        => ONE,
	            addn_sub => '0',
	            s        => b_plus_one,					
	            cout     => c_plus1);
-------------------------------------------------------------------------------------------------
	negb: ENTITY work.Adder_Substractor
	GENERIC MAP(N_Bits   => N_Bits)
	PORT MAP (	x	      => ZEROS,
	            y        => datab,
	            addn_sub => '1',
	            s        => neg_b,					
	            cout     => c_negb);
-------------------------------------------------------------------------------------------------
	WITH selop SELECT
   result <= datab 		WHEN "000",
				 not_b		WHEN "001",
				 a_and_b	   WHEN "010",
		   	 a_or_b		WHEN "011",
			    a_xor_b	   WHEN "100",
				 a_plus_b	WHEN "101",
				 b_plus_one WHEN "110",
				 neg_b		WHEN OTHERS;	
-------------------------------------------------------------------------------------------------
	c_sel <= selop(1 DOWNTO 0);
	WITH c_sel SELECT
		cout <= c_add	 WHEN "01",
				  c_plus1 WHEN "10",
				  c_negb  WHEN "11",
				  '0'		 WHEN OTHERS;
END ARCHITECTURE RTL;
-------------------------------------------------------------------------------------------------