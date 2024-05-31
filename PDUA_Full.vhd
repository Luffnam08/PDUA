------------------------------------------------------------------------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
------------------------------------------------------------------------------------------------------------------------------------------------
ENTITY PDUA_Full IS
	PORT(clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
		  I   : IN STD_LOGIC);
END ENTITY PDUA_Full;
------------------------------------------------------------------------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF PDUA_Full IS
SIGNAL bank_wr_en_w, enaf_w, ir_en_w, mar_en_w, ram_wr_rd_w, ir_sclr_w, mdr_en_w, mdr_alu_n_w, C_w, N_w, P_w, Z_w, int_clr_w, iom_w : STD_LOGIC;
SIGNAL shamt_w : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL BusC_addr_w, BusB_addr_w, selop_w : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL opcode_w : STD_LOGIC_VECTOR(4 DOWNTO 0);
------------------------------------------------------------------------------------------------------------------------------------------------
COMPONENT Proyecto_3_Memoria IS
	PORT(clk        : IN  STD_LOGIC;
        rst        : IN  STD_LOGIC;
        bank_wr_en : IN  STD_LOGIC;
        BusC_addr  : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
        BusB_addr  : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
        selop      : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
        shamt      : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
        enaf       : IN  STD_LOGIC;
     	  ir_en      : IN  STD_LOGIC;
	 	  mar_en     : IN  STD_LOGIC;
		  ram_wr_rd  : IN  STD_LOGIC;
        ir_sclr    : IN  STD_LOGIC;
        mdr_en     : IN  STD_LOGIC;
        mdr_alu_n  : IN  STD_LOGIC;
		  C, N, P, Z : OUT STD_LOGIC;
        opcode     : OUT STD_LOGIC_VECTOR(4 DOWNTO 0));
END COMPONENT;
------------------------------------------------------------------------------------------------------------------------------------------------
COMPONENT Unidad_De_Control IS
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
END COMPONENT;	  
------------------------------------------------------------------------------------------------------------------------------------------------
BEGIN
   Proyecto_3_Memoria_inst: Proyecto_3_Memoria
   PORT MAP(clk        => clk,
				rst        => rst,
				bank_wr_en => bank_wr_en_w,
				BusC_addr  => BusC_addr_w,
				BusB_addr  => BusB_addr_w,
				selop      => selop_w,
				shamt      => shamt_w,
				enaf       => enaf_w,
				ir_en      => ir_en_w,
				mar_en     => mar_en_w,
				ram_wr_rd  => ram_wr_rd_w, 
				ir_sclr    => ir_sclr_w,
				mdr_en     => mdr_en_w,
				mdr_alu_n  => mdr_alu_n_w,
				C          => C_w,
				N          => N_w,
				P          => P_w,
				Z          => Z_w,
				opcode     => opcode_w);
------------------------------------------------------------------------------------------------------------------------------------------------
	Unidad_De_Control_inst: Unidad_De_Control
	PORT MAP(clk        => clk,
				rst        => rst,
				opcode     => opcode_w,
				C          => C_w,
				N          => N_w, 
				P          => P_w, 
				Z          => Z_w,
				I          => I,
				enaf       => enaf_w,
				selop      => selop_w,
				shamt      => shamt_w,
				busB_addr  => BusB_addr_w,
				busC_addr  => BusC_addr_w,
				bank_wr_en => bank_wr_en_w,
				mar_en     => mar_en_w,
				mdr_en     => mdr_en_w,
				mdr_alu_n  => mdr_alu_n_w,
				int_clr    => int_clr_w,
				iom        => iom_w,
				wr_rdn     => ram_wr_rd_w,
				ir_en      => ir_en_w,
				ir_clr     => ir_sclr_w);
------------------------------------------------------------------------------------------------------------------------------------------------
END ARCHITECTURE Behavioral;
------------------------------------------------------------------------------------------------------------------------------------------------ 