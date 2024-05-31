---------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
---------------------------------------------------------
ENTITY Splitter_2 IS
	PORT(uInstruction : IN  STD_LOGIC_VECTOR(20 DOWNTO 0); 
        enaf         : OUT STD_LOGIC;
		  selop        : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		  shamt        : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		  busB_addr    : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		  busC_addr    : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		  bank_wr_en   : OUT STD_LOGIC;
		  mar_en       : OUT STD_LOGIC;
		  mdr_en       : OUT STD_LOGIC;
		  mdr_alu_n    : OUT STD_LOGIC;
		  int_clr      : OUT STD_LOGIC;
		  iom          : OUT STD_LOGIC;
		  wr_rdn       : OUT STD_LOGIC;
		  ir_en        : OUT STD_LOGIC;
		  ir_clr       : OUT STD_LOGIC);
END ENTITY Splitter_2;
---------------------------------------------------------
ARCHITECTURE Behavioral OF Splitter_2 IS
BEGIN
	assign: PROCESS(uInstruction)
   BEGIN
        enaf       <= uInstruction(20);
		  selop      <= uInstruction(19 DOWNTO 17);
		  shamt      <= uInstruction(16 DOWNTO 15);
		  busB_addr  <= uInstruction(14 DOWNTO 12);
		  busC_addr  <= uInstruction(11 DOWNTO 9);
		  bank_wr_en <= uInstruction(8);
		  mar_en     <= uInstruction(7);
		  mdr_en     <= uInstruction(6);
		  mdr_alu_n  <= uInstruction(5);
		  int_clr    <= uInstruction(4);
		  iom        <= uInstruction(3);
		  wr_rdn     <= uInstruction(2);
		  ir_en      <= uInstruction(1);
		  ir_clr     <= uInstruction(0);
	END PROCESS;
---------------------------------------------------------
END ARCHITECTURE Behavioral;
---------------------------------------------------------