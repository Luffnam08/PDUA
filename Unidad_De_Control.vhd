-------------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
-------------------------------------------------------------------------------------
ENTITY Unidad_De_Control IS
	PORT(clk           : IN  STD_LOGIC;
        rst           : IN  STD_LOGIC;
		  opcode        : IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
		  C, N, P, Z, I : IN  STD_LOGIC;
        enaf          : OUT STD_LOGIC;
		  selop         : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		  shamt         : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		  busB_addr     : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		  busC_addr     : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		  bank_wr_en    : OUT STD_LOGIC;
		  mar_en        : OUT STD_LOGIC;
		  mdr_en        : OUT STD_LOGIC;
		  mdr_alu_n     : OUT STD_LOGIC;
		  int_clr       : OUT STD_LOGIC;
		  iom           : OUT STD_LOGIC;
		  wr_rdn        : OUT STD_LOGIC;
		  ir_en         : OUT STD_LOGIC;
		  ir_clr        : OUT STD_LOGIC);
END ENTITY Unidad_De_Control;
-------------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF Unidad_De_Control IS
SIGNAL load_w, cout_w, en_uPC_w, clr_uPC_w : STD_LOGIC;
SIGNAL jcond_w, offset_w, result_w, uresult_w, dataa_w: STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL addr_w : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL uInstruction_w : STD_LOGIC_VECTOR(20 DOWNTO 0);
SIGNAL r_data_w : STD_LOGIC_VECTOR(28 DOWNTO 0);
-------------------------------------------------------------------------------------
COMPONENT JMP_MUX IS
	PORT(C, N, P, Z, I : IN  STD_LOGIC;
        jcond         : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
		  load          : OUT STD_LOGIC);
END COMPONENT;
-------------------------------------------------------------------------------------
COMPONENT uMUX IS
	PORT(rst     : IN  STD_LOGIC;
		  load    : IN  STD_LOGIC;
		  offset  : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
		  result  : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
		  uresult : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
END COMPONENT;
-------------------------------------------------------------------------------------
COMPONENT Adder_Substractor_C IS
	GENERIC(N_Bits   : INTEGER := 3);
   PORT(   dataa    : IN  STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
		     result   : OUT STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
           cout     : OUT STD_LOGIC);
END COMPONENT;
-------------------------------------------------------------------------------------
COMPONENT uPC IS
	GENERIC(N_Bits  : INTEGER := 3);
   PORT(	  clk     : IN  STD_LOGIC;
		     rst     : IN  STD_LOGIC;
		     en_uPC  : IN  STD_LOGIC;
		     clr_uPC : IN  STD_LOGIC;
		     d       : IN  STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
		     q       : OUT STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0));
END COMPONENT;
-------------------------------------------------------------------------------------
COMPONENT Concat_Addr IS
	PORT(opcode : IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
        uIn    : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
        addr   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END COMPONENT;
-------------------------------------------------------------------------------------
COMPONENT upROM IS
	GENERIC(A_Bits : INTEGER := 8;
			  W_Bits : INTEGER := 29);
   PORT(   clk    : IN  STD_LOGIC;
			  addr   : IN  STD_LOGIC_VECTOR(A_Bits-1 DOWNTO 0);
		     r_data : OUT STD_LOGIC_VECTOR(W_Bits-1 DOWNTO 0));
END COMPONENT;
-------------------------------------------------------------------------------------
COMPONENT Splitter IS
	PORT(data_in      : IN  STD_LOGIC_VECTOR(28 DOWNTO 0); 
		  uInstruction : OUT STD_LOGIC_VECTOR(20 DOWNTO 0);
		  en_uPC       : OUT STD_LOGIC;
		  clr_uPC      : OUT STD_LOGIC;
		  jcond        : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		  offset       : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
END COMPONENT;
-------------------------------------------------------------------------------------
COMPONENT Splitter_2 IS
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
END COMPONENT;
-------------------------------------------------------------------------------------
BEGIN
   JMP_MUX_inst: JMP_MUX
   PORT MAP(C     => C,
				N     => N,
				P     => P,
				Z     => Z,
				I     => I,
				jcond => jcond_w,
				load  => load_w);
-------------------------------------------------------------------------------------
	uMUX_inst: uMUX
   PORT MAP(rst     => rst,
				load    => load_w,
				offset  => offset_w,
				result  => result_w,
				uresult => uresult_w);
-------------------------------------------------------------------------------------
	Adder_Substractor_C_inst: Adder_Substractor_C
	PORT MAP(dataa  => dataa_w,
				result => result_w,
				cout   => cout_w);
-------------------------------------------------------------------------------------
	uPC_inst: uPC
	PORT MAP(clk     => clk,
				rst     => rst,
				en_uPC  => en_uPC_w,
				clr_uPC => clr_uPC_w,
				d       => uresult_w,
				q       => dataa_w);
-------------------------------------------------------------------------------------
	Concat_Addr_inst: Concat_Addr
	PORT MAP(opcode => opcode,
				uIn    => dataa_w,
				addr   => addr_w);
-------------------------------------------------------------------------------------
	upROM_inst: upROM
	PORT MAP(clk    => clk,
				addr   => addr_w,
				r_data => r_data_w);
-------------------------------------------------------------------------------------
	Splitter_inst: Splitter
	PORT MAP(data_in      => r_data_w,
				uInstruction => uInstruction_w,
				en_uPC       => en_uPC_w,
				clr_uPC      => clr_uPC_w,
				jcond        => jcond_w,
				offset       => offset_w);
-------------------------------------------------------------------------------------
	Splitter_2_inst: Splitter_2
	PORT MAP(uInstruction => uInstruction_w,
				enaf         => enaf,
				selop        => selop,
				shamt        => shamt,
				busB_addr    => busB_addr,
				busC_addr    => busC_addr,
				bank_wr_en   => bank_wr_en,
				mar_en       => mar_en,
				mdr_en       => mdr_en,
				mdr_alu_n    => mdr_alu_n,
				int_clr      => int_clr,
				iom          => iom,
				wr_rdn       => wr_rdn,
				ir_en        => ir_en,
				ir_clr       => ir_clr);
-------------------------------------------------------------------------------------
END ARCHITECTURE Behavioral;
------------------------------------------------------------------------------------- 