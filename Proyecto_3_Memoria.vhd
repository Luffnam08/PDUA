-------------------------------------------------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
-------------------------------------------------------------------------------------------------------------------------
ENTITY Proyecto_3_Memoria IS
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
END ENTITY Proyecto_3_Memoria;
-------------------------------------------------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF Proyecto_3_Memoria IS
SIGNAL busA_regbank, busB_regbank, ALU_TO_MDR, busC_aux, q_aux, BUS_DATA_OUT, BUS_DATA_IN : STD_LOGIC_VECTOR(7 DOWNTO 0);
-------------------------------------------------------------------------------------------------------------------------
COMPONENT ALU IS
	GENERIC(N_Bits     : INTEGER := 8);
   PORT(   clk        : IN  STD_LOGIC;
           rst        : IN  STD_LOGIC;
           busA       : IN  STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
           busB       : IN  STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
           selop      : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
           shamt      : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
           enaf       : IN  STD_LOGIC;
           busC       : OUT STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
           C, N, P, Z : OUT STD_LOGIC);
END COMPONENT;
-------------------------------------------------------------------------------------------------------------------------
COMPONENT IR IS
	GENERIC(N_Bits  : INTEGER := 8;
           Bits_Op : INTEGER := 5);
   PORT(   clk     : IN  STD_LOGIC;
           rst     : IN  STD_LOGIC;
           ena     : IN  STD_LOGIC;
           busC    : IN  STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
           sclr    : IN  STD_LOGIC;
           opcode  : OUT STD_LOGIC_VECTOR(Bits_Op-1 DOWNTO 0));
END COMPONENT;
-------------------------------------------------------------------------------------------------------------------------
COMPONENT MAR IS
	GENERIC(N_Bits : INTEGER := 8);
   PORT(   clk    : IN  STD_LOGIC;
           rst    : IN  STD_LOGIC;
           ena    : IN  STD_LOGIC;
           d      : IN  STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
           q      : OUT STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0));
END COMPONENT;
-------------------------------------------------------------------------------------------------------------------------
COMPONENT MDR IS
	GENERIC(N_Bits     : INTEGER := 8);
	PORT(   clk  	    : IN  STD_LOGIC;
			  rst  		 : IN  STD_LOGIC;
	        data_in    : IN  STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
           busALU     : IN  STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
           mdr_ena    : IN  STD_LOGIC;
           mdr_alu_no : IN  STD_LOGIC;		  
			  busC       : OUT STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
			  data_out   : OUT STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0));
END COMPONENT;
-------------------------------------------------------------------------------------------------------------------------
COMPONENT Register_Bank IS
	GENERIC( N_Bits      : INTEGER := 8;
            ADDR_WIDTH  : INTEGER := 3);
   PORT(    clk         : IN  STD_LOGIC;
            rst         : IN  STD_LOGIC;
            wr_en       : IN  STD_LOGIC;
            w_addr      : IN  STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0);
            r_addr      : IN  STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0);
            bank_w_data : IN  STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
            busA        : OUT STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
            busB        : OUT STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0));
END COMPONENT;
-------------------------------------------------------------------------------------------------------------------------
COMPONENT RAM IS
	GENERIC(N_Bits     : INTEGER :=8);
	PORT(   clk        : IN  STD_LOGIC;
			  rst        : IN  STD_LOGIC;
		     wr_rdn     : IN  STD_LOGIC;
	        addr       : IN  STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
		     ram_w_data : IN  STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0);
		     r_data     : OUT STD_LOGIC_VECTOR(N_Bits-1 DOWNTO 0));
END COMPONENT;
-------------------------------------------------------------------------------------------------------------------------
BEGIN
   ALU_inst: ALU
   PORT MAP(clk    => clk,
            rst    => rst,
            busA   => busA_regbank,
            busB   => busB_regbank,
            selop  => selop,
            shamt  => shamt,
            enaf   => enaf,
            busC   => ALU_TO_MDR,
            C      => C,
            N      => N,
            P      => P,
            Z      => Z);
-------------------------------------------------------------------------------------------------------------------------
   IR_inst: IR
   PORT MAP(clk     => clk,
            rst     => rst,
            ena     => ir_en,
            busC    => busC_aux,
            sclr    => ir_sclr,
            opcode  => opcode);
-------------------------------------------------------------------------------------------------------------------------
   MAR_inst: MAR
   PORT MAP(clk     => clk,
            rst     => rst,
            ena     => mar_en,
            d       => busC_aux,
            q       => q_aux);
-------------------------------------------------------------------------------------------------------------------------
   MDR_inst: MDR
   PORT MAP(data_in    => BUS_DATA_IN,
            data_out   => BUS_DATA_OUT,
            busALU     => ALU_TO_MDR,
            busC       => busC_aux,
            mdr_ena    => mdr_en,
            mdr_alu_no => mdr_alu_n,
				clk  		  => clk,
            rst 		  => rst);
-------------------------------------------------------------------------------------------------------------------------
	Register_Bank_inst: Register_Bank
   PORT MAP(clk         => clk,
            rst         => rst,
            wr_en       => bank_wr_en,
            w_addr      => BusC_addr,
            r_addr      => BusB_addr,
            bank_w_data => busC_aux,
            busA        => busA_regbank,
            busB        => busB_regbank);
-------------------------------------------------------------------------------------------------------------------------
	RAM_inst: RAM
   PORT MAP(clk  	     => clk,
            rst 	     => rst,
            wr_rdn     => ram_wr_rd,
            addr	     => q_aux,
            ram_w_data => BUS_DATA_OUT,
            r_data     => BUS_DATA_IN);
END ARCHITECTURE Behavioral;
-------------------------------------------------------------------------------------------------------------------------