library IEEE;
use IEEE.STD_LOGIC_1164.all;

ENTITY register_select_logic IS
	PORT(
		ra	: IN  STD_LOGIC_VECTOR(3  DOWNTO 0);
		rb	: IN  STD_LOGIC_VECTOR(3  DOWNTO 0);
		rc	: IN  STD_LOGIC_VECTOR(3  DOWNTO 0);
		g_ra	: IN  STD_LOGIC;
		g_rb	: IN  STD_LOGIC;
		g_rc	: IN  STD_LOGIC;
		r_in	: IN  STD_LOGIC;
		r_out 	: IN  STD_LOGIC;
		
		r0_in	: OUT STD_LOGIC;
		r1_in	: OUT STD_LOGIC;
		r2_in	: OUT STD_LOGIC;
		r3_in	: OUT STD_LOGIC;
		r4_in	: OUT STD_LOGIC;
		r5_in	: OUT STD_LOGIC;
		r6_in	: OUT STD_LOGIC;
		r7_in	: OUT STD_LOGIC;
		r8_in	: OUT STD_LOGIC;
		r9_in	: OUT STD_LOGIC;
		r10_in	: OUT STD_LOGIC;
		r11_in	: OUT STD_LOGIC;
		r12_in	: OUT STD_LOGIC;
		r13_in	: OUT STD_LOGIC;
		r14_in	: OUT STD_LOGIC;
		r15_in	: OUT STD_LOGIC;
		
		r0_out	: OUT STD_LOGIC;
		r1_out	: OUT STD_LOGIC;
		r2_out	: OUT STD_LOGIC;
		r3_out	: OUT STD_LOGIC;
		r4_out	: OUT STD_LOGIC;
		r5_out	: OUT STD_LOGIC;
		r6_out	: OUT STD_LOGIC;
		r7_out	: OUT STD_LOGIC;
		r8_out	: OUT STD_LOGIC;
		r9_out	: OUT STD_LOGIC;
		r10_out	: OUT STD_LOGIC;
		r11_out	: OUT STD_LOGIC;
		r12_out	: OUT STD_LOGIC;
		r13_out	: OUT STD_LOGIC;
		r14_out	: OUT STD_LOGIC;
		r15_out	: OUT STD_LOGIC		
	);
END register_select_logic;

ARCHITECTURE arch OF register_select_logic IS
	SIGNAL decoder_input  : STD_LOGIC_VECTOR(3  DOWNTO 0);
	SIGNAL decoder_output : STD_LOGIC_VECTOR(15 DOWNTO 0);

	COMPONENT four_to_sixteen_decoder IS 
		PORT(
			en_in  : IN  STD_LOGIC_VECTOR(3  DOWNTO 0);
			en_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) 
		);
	END COMPONENT;

BEGIN
	
	PROCESS(ra, g_ra, rb, g_rb, rc, g_rc) IS
	BEGIN
		FOR i IN 0 TO 3 LOOP
			decoder_input(i) <= (ra(i) AND g_ra) OR (rb(i) AND g_rb) OR (rc(i) AND g_rc);
		END LOOP;
	END PROCESS;
	
	decoder : four_to_sixteen_decoder
	PORT MAP(decoder_input, decoder_output);
	
	r0_in	<= decoder_output(0)  AND r_in;
	r1_in	<= decoder_output(1)  AND r_in;
	r2_in	<= decoder_output(2)  AND r_in;
	r3_in	<= decoder_output(3)  AND r_in;
	r4_in	<= decoder_output(4)  AND r_in;
	r5_in	<= decoder_output(5)  AND r_in;
	r6_in	<= decoder_output(6)  AND r_in;
	r7_in	<= decoder_output(7)  AND r_in;
	r8_in	<= decoder_output(8)  AND r_in;
	r9_in	<= decoder_output(9)  AND r_in;
	r10_in	<= decoder_output(10) AND r_in;
	r11_in	<= decoder_output(11) AND r_in;
	r12_in	<= decoder_output(12) AND r_in;
	r13_in	<= decoder_output(13) AND r_in;
	r14_in	<= decoder_output(14) AND r_in;
	r15_in	<= decoder_output(15) AND r_in;
	
	r0_out	<= decoder_output(0)  AND r_out;
	r1_out	<= decoder_output(1)  AND r_out;
	r2_out	<= decoder_output(2)  AND r_out;
	r3_out	<= decoder_output(3)  AND r_out;
	r4_out	<= decoder_output(4)  AND r_out;
	r5_out	<= decoder_output(5)  AND r_out;
	r6_out	<= decoder_output(6)  AND r_out;
	r7_out	<= decoder_output(7)  AND r_out;
	r8_out	<= decoder_output(8)  AND r_out;
	r9_out	<= decoder_output(9)  AND r_out;
	r10_out	<= decoder_output(10) AND r_out;
	r11_out	<= decoder_output(11) AND r_out;
	r12_out	<= decoder_output(12) AND r_out;
	r13_out	<= decoder_output(13) AND r_out;
	r14_out	<= decoder_output(14) AND r_out;
	r15_out	<= decoder_output(15) AND r_out;
END arch;	
