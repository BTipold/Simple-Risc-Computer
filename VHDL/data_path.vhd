-- DATAPATH
--		Instantiation of components and
--		connections between them.

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

ENTITY data_path IS 
	PORT
	(	
		clock_in	: IN  STD_LOGIC;
		stop_in		: IN  STD_LOGIC;
		run_out		: OUT STD_LOGIC;
		reset_in	: IN  STD_LOGIC;
		
		in_port		: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		out_port	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END data_path;

ARCHITECTURE connections of data_path IS

COMPONENT control_unit
	PORT (
		-- CONTROL SIGNALS
		run		: OUT STD_LOGIC;
		clear		: OUT STD_LOGIC;
		read_ctrl	: OUT STD_LOGIC;
		write_ctrl	: OUT STD_LOGIC;
		
		clock 		: IN  STD_LOGIC;
      		reset 		: IN  STD_LOGIC;
      		stop 		: IN  STD_LOGIC;
		con_ff		: IN  STD_LOGIC;
		alu_code	: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		op_code		: IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
		rb_in		: IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
		
		-- REGISTER OUT SIGNALS
     		pc_out		: OUT STD_LOGIC;
		mdr_out		: OUT STD_LOGIC;
		z_hi_out	: OUT STD_LOGIC;
		z_lo_out	: OUT STD_LOGIC;
		hi_out		: OUT STD_LOGIC;
		lo_out		: OUT STD_LOGIC;
		immid_val_out	: OUT STD_LOGIC;
		in_port_out	: OUT STD_LOGIC;
		
		-- REGISTER IN SIGNALS
      		pc_enable	: OUT STD_LOGIC;
		mdr_enable	: OUT STD_LOGIC;
		mar_enable	: OUT STD_LOGIC;
		y_enable	: OUT STD_LOGIC;
		z_enable	: OUT STD_LOGIC;
		hi_enable	: OUT STD_LOGIC;
		lo_enable	: OUT STD_LOGIC;
		con_enable	: OUT STD_LOGIC;
		ir_enable	: OUT STD_LOGIC;
		out_port_en	: OUT STD_LOGIC;
		in_port_en	: OUT STD_LOGIC;
		
		-- REGISTER SELECT LOGIC
		r_out		: OUT STD_LOGIC;
		r_enable	: OUT STD_LOGIC;
		g_ra		: OUT STD_LOGIC;
		g_rb		: OUT STD_LOGIC;
		g_rc		: OUT STD_LOGIC
	);
END COMPONENT;


COMPONENT alu
	PORT(
		A 		: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		B 		: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		op_code 	: IN  STD_LOGIC_VECTOR(3  DOWNTO 0);
		C 		: OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
	);
END COMPONENT;

COMPONENT bus_mux
	PORT(
		PC_in 	 	: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r0_in 	 	: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r1_in 	 	: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r2_in 	 	: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r3_in 	 	: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r4_in 	 	: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r5_in 	 	: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r6_in 	 	: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r7_in 	 	: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r8_in 	 	: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r9_in 		: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r10_in 		: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r11_in 		: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r12_in 		: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r13_in 	 	: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r14_in 	 	: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r15_in 	 	: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		Hi_in 	 	: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		Lo_in 	 	: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		z_hi_in	 	: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		z_lo_in	 	: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		InPort_in 	: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		immid_val 	: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		MDR_in 	 	: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		sel 		: IN  STD_LOGIC_VECTOR(4  DOWNTO 0);
		r_out 	 	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT register_32
	PORT(
		en  		: IN  STD_LOGIC;
		clk 		: IN  STD_LOGIC;
		clr 		: IN  STD_LOGIC;
		D 		: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		q 	 	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT register_zero
	PORT(
		en  		: IN  STD_LOGIC;
		clk 		: IN  STD_LOGIC;
		clr 		: IN  STD_LOGIC;
		D 	 	: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		q 	 	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT register_z
	PORT(
		z_en 	  	: IN  STD_LOGIC;
		clock   	: IN  STD_LOGIC;
		clear   	: IN  STD_LOGIC;
		alu_out 	: IN  STD_LOGIC_VECTOR(63 DOWNTO 0);
		z_hi 	  	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		z_lo 	  	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT instruction_register 
	PORT(
		D	 	: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		opcode		: OUT STD_LOGIC_VECTOR(4  DOWNTO 0);
		ra	 	: OUT STD_LOGIC_VECTOR(3  DOWNTO 0);
		rb	 	: OUT STD_LOGIC_VECTOR(3  DOWNTO 0);
		rc	 	: OUT STD_LOGIC_VECTOR(3  DOWNTO 0);
		value_i		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		en  		: IN  STD_LOGIC;
		clk 		: IN  STD_LOGIC;
		clr 		: IN  STD_LOGIC
	);
END COMPONENT;

COMPONENT register_select_logic
	port(
		ra	 	: IN  STD_LOGIC_VECTOR(3  DOWNTO 0);
		rb	 	: IN  STD_LOGIC_VECTOR(3  DOWNTO 0);
		rc	 	: IN  STD_LOGIC_VECTOR(3  DOWNTO 0);
		g_ra		: IN  STD_LOGIC;
		g_rb		: IN  STD_LOGIC;
		g_rc		: IN  STD_LOGIC;
		r_in		: IN  STD_LOGIC;
		r_out 		: IN  STD_LOGIC;
		
		r0_in		: OUT STD_LOGIC;
		r1_in		: OUT STD_LOGIC;
		r2_in		: OUT STD_LOGIC;
		r3_in		: OUT STD_LOGIC;
		r4_in		: OUT STD_LOGIC;
		r5_in		: OUT STD_LOGIC;
		r6_in		: OUT STD_LOGIC;
		r7_in		: OUT STD_LOGIC;
		r8_in		: OUT STD_LOGIC;
		r9_in		: OUT STD_LOGIC;
		r10_in		: OUT STD_LOGIC;
		r11_in		: OUT STD_LOGIC;
		r12_in		: OUT STD_LOGIC;
		r13_in		: OUT STD_LOGIC;
		r14_in		: OUT STD_LOGIC;
		r15_in		: OUT STD_LOGIC;
		
		r0_out		: OUT STD_LOGIC;
		r1_out		: OUT STD_LOGIC;
		r2_out		: OUT STD_LOGIC;
		r3_out		: OUT STD_LOGIC;
		r4_out		: OUT STD_LOGIC;
		r5_out		: OUT STD_LOGIC;
		r6_out		: OUT STD_LOGIC;
		r7_out		: OUT STD_LOGIC;
		r8_out		: OUT STD_LOGIC;
		r9_out		: OUT STD_LOGIC;
		r10_out		: OUT STD_LOGIC;
		r11_out		: OUT STD_LOGIC;
		r12_out		: OUT STD_LOGIC;
		r13_out		: OUT STD_LOGIC;
		r14_out		: OUT STD_LOGIC;
		r15_out		: OUT STD_LOGIC		
	);
END COMPONENT;

COMPONENT mux_2to1
	PORT(
		sel    		: IN  STD_LOGIC;
		A 		: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		B	 	: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		output 		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT encoder
	PORT(
		PCout 		: IN  STD_LOGIC;
		ROout 		: IN  STD_LOGIC;
		R1out 		: IN  STD_LOGIC;
		R2out 		: IN  STD_LOGIC;
		R3out 		: IN  STD_LOGIC;
		R4out 		: IN  STD_LOGIC;
		R5out 		: IN  STD_LOGIC;
		R6out 		: IN  STD_LOGIC;
		R7out 		: IN  STD_LOGIC;
		R8out 		: IN  STD_LOGIC;
		R9out 		: IN  STD_LOGIC;
		R10out 		: IN  STD_LOGIC;
		R11out 		: IN  STD_LOGIC;
		R12out 		: IN  STD_LOGIC;
		R13out 		: IN  STD_LOGIC;
		R14out 		: IN  STD_LOGIC;
		R15out 		: IN  STD_LOGIC;
		HIout 		: IN  STD_LOGIC;
		LOout 		: IN  STD_LOGIC;
		ZHiOut		: IN  STD_LOGIC;
		ZLoOut		: IN  STD_LOGIC;
		MDRout 		: IN  STD_LOGIC;
		InPortOut	: IN  STD_LOGIC;
		immid_val	: IN  STD_LOGIC;
		encoder_out 	: OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
END COMPONENT;

COMPONENT conditional_logic
	PORT(
		c2_field	: IN  STD_LOGIC_VECTOR(3  DOWNTO 0);
		con_in		: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		con_en		: IN  STD_LOGIC;
		con_out		: OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT ram_module
	PORT
	(
		address		: IN  STD_LOGIC_VECTOR (8 DOWNTO 0);
		clock		: IN  STD_LOGIC;
		data		: IN  STD_LOGIC_VECTOR (31 DOWNTO 0);
		rden		: IN  STD_LOGIC;
		wren		: IN  STD_LOGIC;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END COMPONENT;

-- SIGNALS
-- ALU SIGNALS
SIGNAL alu_a_in		: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL alu_to_z		: STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL ALUsel_signal	: STD_LOGIC_VECTOR(3 DOWNTO 0);

-- CONTROL SIGNAL
SIGNAL clear_signal 	: STD_LOGIC;
SIGNAL clock_signal 	: STD_LOGIC;
SIGNAL con_signal	: STD_LOGIC;
SIGNAL read_signal	: STD_LOGIC;
SIGNAL write_signal	: STD_LOGIC;
SIGNAL bus_select	: STD_LOGIC_VECTOR(4  DOWNTO 0);
SIGNAL OPcode_signal	: STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL bus_signal	: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL r_out_signal	: STD_LOGIC;
SIGNAL r_in_signal	: STD_LOGIC;
SIGNAL CONen_signal	: STD_LOGIC;
SIGNAL clr_in_signal 	: STD_LOGIC;

-- Register enable signals
SIGNAL r0_in_signal	: STD_LOGIC;
SIGNAL r1_in_signal	: STD_LOGIC;
SIGNAL r2_in_signal	: STD_LOGIC;
SIGNAL r3_in_signal	: STD_LOGIC;
SIGNAL r4_in_signal	: STD_LOGIC;
SIGNAL r5_in_signal	: STD_LOGIC;
SIGNAL r6_in_signal	: STD_LOGIC;
SIGNAL r7_in_signal	: STD_LOGIC;
SIGNAL r8_in_signal	: STD_LOGIC;
SIGNAL r9_in_signal	: STD_LOGIC;
SIGNAL r10_in_signal	: STD_LOGIC;
SIGNAL r11_in_signal	: STD_LOGIC;
SIGNAL r12_in_signal	: STD_LOGIC;
SIGNAL r13_in_signal	: STD_LOGIC;
SIGNAL r14_in_signal	: STD_LOGIC;
SIGNAL r15_in_signal	: STD_LOGIC;

SIGNAL Zin_signal	: STD_LOGIC;
SIGNAL Yin_signal	: STD_LOGIC;
SIGNAL MDRen_signal	: STD_LOGIC;
SIGNAL MARin_signal	: STD_LOGIC;
SIGNAL HIin_signal	: STD_LOGIC;
SIGNAL LOin_signal	: STD_LOGIC;
SIGNAL input_in_sig	: STD_LOGIC;
SIGNAL output_in_sig	: STD_LOGIC;
SIGNAL IRin_signal	: STD_LOGIC;
SIGNAL PCen_signal	: STD_LOGIC;

-- Register output signals
SIGNAL r0_out_signal	: STD_LOGIC;
SIGNAL r1_out_signal	: STD_LOGIC;
SIGNAL r2_out_signal	: STD_LOGIC;
SIGNAL r3_out_signal	: STD_LOGIC;
SIGNAL r4_out_signal	: STD_LOGIC;
SIGNAL r5_out_signal	: STD_LOGIC;
SIGNAL r6_out_signal	: STD_LOGIC;
SIGNAL r7_out_signal	: STD_LOGIC;
SIGNAL r8_out_signal	: STD_LOGIC;
SIGNAL r9_out_signal	: STD_LOGIC;
SIGNAL r10_out_signal	: STD_LOGIC;
SIGNAL r11_out_signal	: STD_LOGIC;
SIGNAL r12_out_signal	: STD_LOGIC;
SIGNAL r13_out_signal	: STD_LOGIC;
SIGNAL r14_out_signal	: STD_LOGIC;
SIGNAL r15_out_signal	: STD_LOGIC;

SIGNAL z_hi_out_sig	: STD_LOGIC;
SIGNAL z_lo_out_sig	: STD_LOGIC;
SIGNAL MDRout_signal	: STD_LOGIC;
SIGNAL HIout_signal	: STD_LOGIC;
SIGNAL LOout_signal	: STD_LOGIC;
SIGNAL immid_out_sig	: STD_LOGIC;
SIGNAL input_out_sig	: STD_LOGIC;
SIGNAL PCout_signal	: STD_LOGIC;

-- Register data wire
SIGNAL PC_wire 	 	: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL r0_wire 	 	: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL r1_wire 	 	: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL r2_wire 	 	: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL r3_wire 	 	: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL r4_wire 	 	: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL r5_wire 	 	: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL r6_wire 	 	: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL r7_wire 	 	: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL r8_wire 	 	: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL r9_wire 	 	: STD_LOGIC_VECTOR(31 DOWNTO 0)
SIGNAL r10_wire 	: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL r11_wire 	: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL r12_wire 	: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL r13_wire 	: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL r14_wire 	: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL r15_wire 	: STD_LOGIC_VECTOR(31 DOWNTO 0)
	
SIGNAL z_hi_wire 	: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL z_lo_wire 	: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL InPort_wire  	: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL Lo_wire 		: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL Hi_wire 		: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL MDMux_out 	: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL mdr_wire 	: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL m_data_in	: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL address_wire	: STD_LOGIC_VECTOR(31 DOWNTO 0);

-- Wires from instruction register
SIGNAL immid_wire	: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL ra_wire		: STD_LOGIC_VECTOR(3  DOWNTO 0);
SIGNAL rb_wire		: STD_LOGIC_VECTOR(3  DOWNTO 0);
SIGNAL rc_wire		: STD_LOGIC_VECTOR(3  DOWNTO 0);
SIGNAL gra_signal	: STD_LOGIC;
SIGNAL grb_signal	: STD_LOGIC;
SIGNAL grc_signal	: STD_LOGIC;

BEGIN 
clock_signal <= clock_in;

-- PORT MAPPINGS
cntl: control_unit
PORT MAP(
	clock 		=> clock_signal, 
	reset 		=> reset_in,
	stop 		=> stop_in,
	con_ff		=> con_signal,
	run		=> run_out,
	clear		=> clear_signal,
	read_ctrl	=> read_signal,		
	write_ctrl	=> write_signal,
	alu_code	=> ALUsel_signal,
	op_code		=> OPcode_signal,
	rb_in		=> rb_wire,

	-- REGISTER OUT SIGNALS
	pc_out		=> PCout_signal,
	mdr_out		=> MDRout_signal,
	z_hi_out	=> z_hi_out_sig,
	z_lo_out	=> z_lo_out_sig,
	hi_out		=> HIout_signal,
	lo_out		=> LOout_signal,
	immid_val_out	=> immid_out_sig,
	in_port_out	=> input_out_sig,

	-- REGISTER IN SIGNALS
	pc_enable	=> PCen_signal,
	mdr_enable	=> MDRen_signal,
	mar_enable	=> MARin_signal,
	y_enable	=> Yin_signal,
	z_enable	=> Zin_signal,
	hi_enable	=> HIin_signal,
	lo_enable	=> LOin_signal,
	con_enable	=> CONen_signal,
	ir_enable	=> IRin_signal,
	out_port_en	=> output_in_sig,
	in_port_en	=> input_in_sig,

	-- REGISTER SELECT LOGIC
	r_out		=> r_in_signal,
	r_enable	=> r_out_signal,
	g_ra		=> gra_signal,
	g_rb		=> grb_signal,
	g_rc		=> grc_signal
);


mux : bus_mux
PORT MAP(
	PC_in 	 	=> PC_wire,
	r0_in 	 	=> r0_wire,
	r1_in 	 	=> r1_wire,
	r2_in 	 	=> r2_wire,
	r3_in 	 	=> r3_wire,
	r4_in 	 	=> r4_wire,
	r5_in 	 	=> r5_wire,
	r6_in 	 	=> r6_wire,
	r7_in 	 	=> r7_wire,
	r8_in 	 	=> r8_wire,
	r9_in 	 	=> r9_wire,
	r10_in 	 	=> r10_wire,
	r11_in 	 	=> r11_wire,
	r12_in 	 	=> r12_wire,
	r13_in 	 	=> r13_wire,
	r14_in 	 	=> r14_wire,
	r15_in 	 	=> r15_wire,
	
	Hi_in 	 	=> Hi_wire,
	Lo_in 	 	=> Lo_wire,
	z_hi_in	 	=> z_hi_wire,
	z_lo_in	 	=> z_lo_wire,
	InPort_in	=> InPort_wire,
	Immid_val 	=> immid_wire,
	MDR_in 	 	=> mdr_wire,
	
	sel 		=> bus_select,
	r_out 	 	=> bus_signal
);

register_selector : encoder
PORT MAP(
	ROout 		=> r0_out_signal,
	R1out 		=> r1_out_signal,
	R2out 		=> r2_out_signal,
	R3out 		=> r3_out_signal,
	R4out 		=> r4_out_signal,
	R5out 		=> r5_out_signal,
	R6out 		=> r6_out_signal,
	R7out 		=> r7_out_signal,
	R8out 		=> r8_out_signal,
	R9out		=> r9_out_signal,
	R10out 		=> r10_out_signal,
	R11out 		=> r11_out_signal,
	R12out 		=> r12_out_signal,
	R13out 		=> r13_out_signal,
	R14out 		=> r14_out_signal,
	R15out 		=> r15_out_signal,
	HIout 		=> HIout_signal,
	LOout 		=> LOout_signal,
	ZHiOut		=> z_hi_out_sig,
	ZLoOut		=> z_lo_out_sig,
	PCout 		=> PCout_signal,
	MDRout 		=> MDRout_signal,
	InPortOut 	=> input_out_sig,
	immid_val	=> immid_out_sig,
	encoder_out 	=> bus_select
);

-- PROGRAM COUNTER
program_counter: register_32
PORT MAP(
	en  	=> PCen_signal,
	clk	=> clock_signal,
	clr 	=> clear_signal,
	D 	=> bus_signal,
	q 	=> pc_wire
);


-- REGISTERS 0 TO 15
reg_0	: register_zero
PORT MAP(
	en  	=> r0_in_signal,
	clk 	=> clock_signal,
	clr 	=> clear_signal,
	D 	=> bus_signal,
	q 	=> r0_wire
);

reg_1 : register_32
PORT MAP(
	en  	=> r1_in_signal,
	clk	=> clock_signal,
	clr 	=> clear_signal,
	D 	=> bus_signal,
	q 	=> r1_wire
);


reg_2 : register_32
PORT MAP(
	en  	=> r2_in_signal,
	clk 	=> clock_signal,
	clr 	=> clear_signal,
	D 	=> bus_signal,
	q 	=> r2_wire
);


reg_3 : register_32
PORT MAP(
	en  	=> r3_in_signal,
	clk 	=> clock_signal,
	clr 	=> clear_signal,
	D 	=> bus_signal,
	q 	=> r3_wire
);


reg_4 : register_32
PORT MAP(
	en  	=> r4_in_signal,
	clk 	=> clock_signal,
	clr 	=> clear_signal,
	D 	=> bus_signal,
	q 	=> r4_wire
);


reg_5 : register_32
PORT MAP(
	en  	=> r5_in_signal,
	clk 	=> clock_signal,
	clr 	=> clear_signal,
	D   	=> bus_signal,
	q 	=> r5_wire
);


reg_6 : register_32
PORT MAP(
	en  	=> r6_in_signal,
	clk 	=> clock_signal,
	clr 	=> clear_signal,
	D 	=> bus_signal,
	q 	=> r6_wire
);


reg_7 : register_32
PORT MAP(
	en  	=> r7_in_signal,
	clk 	=> clock_signal,
	clr	=> clear_signal,
	D   	=> bus_signal,
	q 	=> r7_wire
);


reg_8 : register_32
PORT MAP(
	en  	=> r8_in_signal,
	clk 	=> clock_signal,
	clr 	=> clear_signal,
	D   	=> bus_signal,
	q 	=> r8_wire
);


reg_9 : register_32
PORT MAP(
	en  	=> r9_in_signal,
	clk 	=> clock_signal,
	clr 	=> clear_signal,
	D 	=> bus_signal,
	q 	=> r9_wire
);

reg_10 : register_32
PORT MAP(
	en  	=> r10_in_signal,
	clk	=> clock_signal,
	clr 	=> clear_signal,
	D 	=> bus_signal,
	q 	=> r10_wire
);


reg_11 : register_32
PORT MAP(
	en  	=> r11_in_signal,
	clk 	=> clock_signal,
	clr 	=> clear_signal,
	D 	=> bus_signal,
	q 	=> r11_wire
);


reg_12 : register_32
PORT MAP(
	en  	=> r12_in_signal,
	clk 	=> clock_signal,
	clr 	=> clear_signal,
	D 	=> bus_signal,
	q 	=> r12_wire
);


reg_13 : register_32
PORT MAP(
	en  	=> r13_in_signal,
	clk 	=> clock_signal,
	clr 	=> clear_signal,
	D 	=> bus_signal,
	q 	=> r13_wire
);


reg_14 : register_32
PORT MAP(
	en  	=> r14_in_signal,
	clk 	=> clock_signal,
	clr 	=> clear_signal,
	D 	=> bus_signal,
	q 	=> r14_wire
);


reg_15 : register_32
PORT MAP(
	en  	=> r15_in_signal,
	clk 	=> clock_signal,
	clr 	=> clear_signal,
	D 	=> bus_signal,
	q 	=> r15_wire
);

-- ALU
logic_unit : alu
PORT MAP(
	A 	=> alu_a_in,
	B 	=> bus_signal,
	op_code => ALUsel_signal,
	C 	=> alu_to_z
);

-- OTHER REGISTERS
high : register_32
PORT MAP(
	en  	=> HIin_signal,
	clk 	=> clock_signal,
	clr 	=> clear_signal,
	D 	=> bus_signal,
	q 	=> hi_wire
);

low : register_32
PORT MAP(
	en  	=> LOin_signal,
	clk 	=> clock_signal,
	clr 	=> clear_signal,
	D 	=> bus_signal,
	q 	=> Lo_wire
);

InPort : register_32
PORT MAP(
	en  	=> input_in_sig,
	clk 	=> clock_signal,
	clr 	=> clear_signal,
	D 	=> in_port,
	q 	=> InPort_wire
);

OutPort : register_32
PORT MAP(
	en  	=> output_in_sig,
	clk 	=> clock_signal,
	clr 	=> clear_signal,
	D 	=> bus_signal,
	q 	=> out_port
);

-- REGISTER Y
y : register_32
PORT MAP(
	en 	=> Yin_signal,
	clk	=> clock_signal,
	clr	=> clear_signal,
	D 	=> bus_signal,
	q 	=> alu_a_in
);

-- REGISTER Z
z : register_z
PORT MAP(
	z_en    => Zin_signal,
	clock   => clock_signal,
	clear   => clear_signal,
	alu_out => alu_to_z,
	z_hi 	=> z_hi_wire,
	z_lo 	=> z_lo_wire
);

-- INSTRUCTION REGISTER
ir	: instruction_register 
PORT MAP(
	D	=> bus_signal,
	opcode  => opcode_signal,
	ra	=> ra_wire,
	rb	=> rb_wire,
	rc	=> rc_wire,
	value_i	=> immid_wire,
	en	=> IRin_signal,
	clk	=> clock_signal,
	clr	=> clear_signal
);

ir_selection_logic : register_select_logic
PORT MAP(
	ra	=> ra_wire,
	rb	=> rb_wire,
	rc	=> rc_wire,
	g_ra	=> gra_signal,
	g_rb	=> grb_signal,
	g_rc	=> grc_signal,
	r_in	=> r_out_signal,
	r_out	=> r_in_signal,

	r0_in	=> r0_in_signal,
	r1_in	=> r1_in_signal,
	r2_in	=> r2_in_signal,
	r3_in	=> r3_in_signal,
	r4_in	=> r4_in_signal,
	r5_in	=> r5_in_signal,
	r6_in	=> r6_in_signal,
	r7_in	=> r7_in_signal,
	r8_in	=> r8_in_signal,
	r9_in	=> r9_in_signal,
	r10_in  => r10_in_signal,
	r11_in  => r11_in_signal,
	r12_in  => r12_in_signal,
	r13_in  => r13_in_signal,
	r14_in  => r14_in_signal,
	r15_in  => r15_in_signal,

	r0_out  => r0_out_signal,
	r1_out  => r1_out_signal,
	r2_out  => r2_out_signal,
	r3_out  => r3_out_signal,
	r4_out  => r4_out_signal,
	r5_out  => r5_out_signal,
	r6_out  => r6_out_signal,
	r7_out  => r7_out_signal,
	r8_out  => r8_out_signal,
	r9_out  => r9_out_signal,
	r10_out => r10_out_signal,
	r11_out => r11_out_signal,
	r12_out => r12_out_signal,
	r13_out => r13_out_signal,
	r14_out => r14_out_signal,
	r15_out => r15_out_signal
);

-- RAM
md_mux: mux_2to1
PORT MAP(	
	sel 	=> read_signal,
	A 	=> bus_signal,
	B 	=> m_data_in,
	output	=> mdmux_out
);

mdr: register_32
PORT MAP(
	en  	=> MDRen_signal,
	clk 	=> clock_signal,
	clr 	=> clear_signal,
	D 	=> mdmux_out,
	q 	=> mdr_wire
);

MAR: register_32
PORT MAP(
	en 	=> MARin_signal,
	clk 	=> clock_signal,
	clr 	=> clear_signal,
	D	=> bus_signal,
	q  	=> address_wire
);

ram: ram_module
PORT MAP(
	address	=> address_wire(8 DOWNTO 0),
	clock	=> clock_signal,
	rden	=> read_signal,
	wren	=> write_signal,
	q	=> m_data_in,
	data	=> bus_signal
);

-- BRANCH LOGIC
con_ff: conditional_logic
PORT MAP(
	c2_field	=> rb_wire,
	con_in		=> bus_signal,
	con_en		=> CONen_signal,
	con_out		=> con_signal
);

END ARCHITECTURE;
