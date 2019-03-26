LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- CONTROL UNIT
--		Asserts control signals according
--		to each instruction in memory.

ENTITY control_unit IS
	PORT (
		-- CONTROL SIGNALS
		clock 		: IN  STD_LOGIC;
      		reset 		: IN  STD_LOGIC;
      		stop 		: IN  STD_LOGIC;
		con_ff		: IN  STD_LOGIC;
		run		: OUT STD_LOGIC;
		clear		: OUT STD_LOGIC;
		read_ctrl	: OUT STD_LOGIC;
		write_ctrl	: OUT STD_LOGIC;
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
END control_unit;

ARCHITECTURE arch OF control_unit IS

TYPE state IS (	init, halt, 
		fetch_instr_0,	fetch_instr_1, fetch_instr_2, fetch_instr_3, fetch_instr_4,
		load, load_1, load_2, load_3, load_4, load_5,
		load_i, load_i_1, load_i_2, load_i_3,
		store, store_1, store_2, store_3, store_4,
		add, add_1, add_2,
		sub, sub_1, sub_2,
		and_0, and_1, and_2,
		or_0, or_1, or_2,
		shift_r, shift_r_1, shift_r_2,
		shift_r_a, shift_r_a_1,	shift_r_a_2,
		shift_l, shift_l_1, shift_l_2,
		rotate_r, rotate_r_1, rotate_r_2,
		rotate_l, rotate_l_1, rotate_l_2,
		add_i, add_i_1, add_i_2, add_i_3, add_i_4, add_i_5,
		or_i, or_i_1, or_i_2, or_i_3, or_i_4, or_i_5, 
		and_i, and_i_1, and_i_2, and_i_3, 
		mul, mul_1, mul_2, mul_3, 
		divide,	divide_1, divide_2, divide_3,
		negate,	negate_1, negate_2,
		not_0, not_1, not_2,
		branch,	branch_1,
		jr,
		jal, jal_1,
		input,
		output,
		mfhi,
		mflo,
		nop
);
						
SIGNAL present_state: state;

BEGIN

PROCESS(clock, reset)
BEGIN
	IF reset = '1' THEN
		present_state <= init;
	ELSIF (rising_edge(clock)) THEN
		CASE present_state IS
			WHEN init	=>
				present_state <= fetch_instr_0;
			WHEN fetch_instr_0	=>
				present_state <= fetch_instr_1;
			WHEN fetch_instr_1	=>
				present_state <= fetch_instr_2;
			WHEN fetch_instr_2	=>
				present_state <= fetch_instr_3;
			WHEN fetch_instr_3	=>
				present_state <= fetch_instr_4;
			WHEN fetch_instr_4	=>
				CASE op_code IS
					WHEN "00000" =>
						present_state <= load;
					WHEN "00001" =>
						present_state <= load_i;
					WHEN "00010" =>
						present_state <= store;
					WHEN "00011" =>
						present_state <= add;
					WHEN "00100" =>
						present_state <= sub;
					WHEN "00101" =>
						present_state <= and_0;
					WHEN "00110" =>
						present_state <= or_0;
					WHEN "00111" =>
						present_state <= shift_r;
					WHEN "01000" =>
						present_state <= shift_r_a;
					WHEN "01001" =>
						present_state <= shift_l;
					WHEN "01010" =>
						present_state <= rotate_r;
					WHEN "01011" =>
						present_state <= rotate_l;
					WHEN "01100" =>
						present_state <= add_i;
					WHEN "01101" =>
						present_state <= and_i;
					WHEN "01110" =>
						present_state <= or_i;
					WHEN "01111" =>
						present_state <= mul;
					WHEN "10000" =>
						present_state <= divide;
					WHEN "10001" =>
						present_state <= negate;
					WHEN "10010" =>
						present_state <= not_0;
					WHEN "10011" =>
						present_state <= branch;
					WHEN "10100" =>
						present_state <= jr;
					WHEN "10101" =>
						present_state <= jal;
					WHEN "10110" =>
						present_state <= input;
					WHEN "10111" =>
						present_state <= output;
					WHEN "11000" =>
						present_state <= mfhi;
					WHEN "11001" =>
						present_state <= mflo;
					WHEN "11010" =>
						present_state <= nop;
					WHEN "11011" =>
						present_state <= halt;
					WHEN OTHERS =>
						present_state <= init;
				END CASE;
				
				-- LOAD
				WHEN load	=>
					present_state <= load_1;
				WHEN load_1	=>
					present_state <= load_2;
				WHEN load_2	=>
					present_state <= load_3;
				WHEN load_3	=>
					present_state <= load_4;
				WHEN load_4	=>
					present_state <= fetch_instr_0;
					
				-- LOAD IMMIDIATE
				WHEN load_i	=>
					present_state <= load_i_1;
				WHEN load_i_1	=>
					present_state <= load_i_2;
				WHEN load_i_2	=>
					present_state <= fetch_instr_0;	
					
				-- STORE
				WHEN store	=>
					present_state <= store_1;
				WHEN store_1	=>
					present_state <= store_2;
				WHEN store_2	=>
					present_state <= store_3;
				WHEN store_3	=>
					present_state <= fetch_instr_0;
				
				-- ADD
				WHEN add	=>
					present_state <= add_1;
				WHEN add_1	=>
					present_state <= add_2;
				WHEN add_2	=>
					present_state <= fetch_instr_0;
					
				-- SUB
				WHEN sub	=>
					present_state <= sub_1;
				WHEN sub_1	=>
					present_state <= sub_2;
				WHEN sub_2	=>
					present_state <= fetch_instr_0;
					
				-- OR
				WHEN or_0	=>
					present_state <= or_1;
				WHEN or_1	=>
					present_state <= or_2;
				WHEN or_2	=>
					present_state <= fetch_instr_0;
					
				-- AND
				WHEN and_0	=>
					present_state <= and_1;
				WHEN and_1	=>
					present_state <= and_2;
				WHEN and_2	=>
					present_state <= fetch_instr_0;
					
				-- SHR
				WHEN shift_r	=>
					present_state <= shift_r_1;
				WHEN shift_r_1	=>
					present_state <= shift_r_2;
				WHEN shift_r_2	=>
					present_state <= fetch_instr_0;
					
				-- SHRA
				WHEN shift_r_a	=>
					present_state <= shift_r_a_1;
				WHEN shift_r_a_1	=>
					present_state <= shift_r_a_2;
				WHEN shift_r_a_2	=>
					present_state <= fetch_instr_0;
					
				-- SHL
				WHEN shift_l	=>
					present_state <= shift_l_1;
				WHEN shift_l_1	=>
					present_state <= shift_l_2;
				WHEN shift_l_2	=>
					present_state <= fetch_instr_0;
					
				-- ROR
				WHEN rotate_r	=>
					present_state <= rotate_r_1;
				WHEN rotate_r_1	=>
					present_state <= rotate_r_2;
				WHEN rotate_r_2	=>
					present_state <= fetch_instr_0;
				
				-- ROL
				WHEN rotate_l	=>
					present_state <= rotate_l_1;
				WHEN rotate_l_1	=>
					present_state <= rotate_l_2;
				WHEN rotate_l_2	=>
					present_state <= fetch_instr_0;
					
				-- ADDI
				WHEN add_i	=>
					present_state <= add_i_1;
				WHEN add_i_1	=>
					present_state <= add_i_2;
				WHEN add_i_2	=>
					present_state <= fetch_instr_0;
					
				-- AND I 
				WHEN and_i	=>
					present_state <= and_i_1;
				WHEN and_i_1	=>
					present_state <= and_i_2;
				WHEN and_i_2	=>
					present_state <= fetch_instr_0;
					
				-- OR I
				WHEN or_i	=>
					present_state <= or_i_1;
				WHEN or_i_1	=>
					present_state <= or_i_2;
				WHEN or_i_2	=>
					present_state <= fetch_instr_0;
					
				-- BRANCH
				WHEN branch	=>
					present_state <= branch_1;
				WHEN branch_1	=>
					present_state <= fetch_instr_0;
					
				-- MUL
				WHEN mul	=>
					present_state <= mul_1;
				WHEN mul_1	=>
					present_state <= mul_2;
				WHEN mul_2	=>
					present_state <= mul_3;
				WHEN mul_3	=>
					present_state <= fetch_instr_0;
					
				-- DIV
				WHEN divide	=>
					present_state <= divide_1;
				WHEN divide_1	=>
					present_state <= divide_2;
				WHEN divide_2	=>
					present_state <= divide_3;
				WHEN divide_3	=>
					present_state <= fetch_instr_0;
					
				-- NOT
				WHEN not_0	=>
					present_state <= not_1;
				WHEN not_1	=>
					present_state <= not_2;
				WHEN not_2	=>
					present_state <= fetch_instr_0;
					
				-- DEG
				WHEN negate	=>
					present_state <= negate_1;
				WHEN negate_1	=>
					present_state <= negate_2;
				WHEN negate_2	=>
					present_state <= fetch_instr_0;
					
				-- mfhi
				WHEN mfhi	=>
					present_state <= fetch_instr_0;
					
				-- mflo
				WHEN mflo	=>
					present_state <= fetch_instr_0;
					
				-- jr
				WHEN jr	=>
					present_state <= fetch_instr_0;
					
				-- jal
				WHEN jal	=>
					present_state <= jal_1;
				WHEN jal_1	=>
					present_state <= fetch_instr_0;
					
				-- Nop
				WHEN nop	=>
					present_state <= fetch_instr_0;
					
				-- Nop
				WHEN halt	=>
					present_state <= halt;
					
				WHEN OTHERS =>
					present_state <= init;
		END CASE;
	END IF;
END PROCESS;

PROCESS(present_state)
BEGIN
	CASE present_state IS
		-- INITIALIZE
		WHEN init =>
			run		<= '1';
			clear		<= '1';
			
			pc_out		<= '0';
			mdr_out		<= '0';
			z_hi_out	<= '0';
			z_lo_out	<= '0';
			hi_out		<= '0';
			lo_out		<= '0';
			immid_val_out	<= '0';
			
			pc_enable	<= '0';
			mdr_enable	<= '0';
			mar_enable	<= '0';
			y_enable	<= '0';
			z_enable	<= '0';
			hi_enable	<= '0';
			lo_enable	<= '0';
			con_enable	<= '0';
			ir_enable	<= '0';
			out_port_en	<= '0';
			
			r_out		<= '0';
			r_enable	<= '0';
			g_ra		<= '0';
			g_rb		<= '0';
			g_rc		<= '0';
			
		-- FETCH INSTRUCTION
		WHEN fetch_instr_0 =>
			write_ctrl	<= '0';
			read_ctrl	<= '0';
			clear		<= '0';
			mdr_out		<= '0';
			z_hi_out	<= '0';
			z_lo_out	<= '0';
			hi_out		<= '0';
			lo_out		<= '0';
			immid_val_out	<= '0';
			pc_enable	<= '0';
			mdr_enable	<= '0';
			y_enable	<= '0';
			hi_enable	<= '0';
			lo_enable	<= '0';
			con_enable	<= '0';
			ir_enable	<= '0';
			out_port_en	<= '0';
			r_out		<= '0';
			r_enable	<= '0';
			g_ra		<= '0';
			g_rb		<= '0';
			g_rc		<= '0';
			pc_out		<= '1';
			mar_enable	<= '1';
			z_enable	<= '1';
			alu_code	<= "1100";
		WHEN fetch_instr_1 =>
			z_lo_out	<= '1';
			pc_enable	<= '1';
			pc_out		<= '0';
			mar_enable	<= '0';
			z_enable	<= '0';
		WHEN fetch_instr_2 =>
			z_lo_out	<= '0';
			pc_enable	<= '0';
			read_ctrl	<= '1';
			mdr_enable	<= '1';
		WHEN fetch_instr_3 =>
			mdr_enable	<= '0';
			read_ctrl	<= '0';
			mdr_out		<= '1';
			ir_enable	<= '1';
		WHEN fetch_instr_4 =>
			mdr_out		<= '0';
			ir_enable	<= '0';
			
		-- LOADS
		WHEN load	=>
			g_rb		<= '1';
			r_out		<= '1';
			y_enable	<= '1';
		WHEN load_1	=>
			immid_val_out	<= '1';
			z_enable	<= '1';
			alu_code	<= "0000";
			g_rb		<= '0';
			r_out		<= '0';
			y_enable	<= '0';
		WHEN load_2	=>
			z_lo_out	<= '1';
			mar_enable	<= '1';
			immid_val_out	<= '0';
			z_enable	<= '0';
		WHEN load_3	=>
			read_ctrl	<= '1';
			mdr_enable	<= '1';
			z_lo_out	<= '0';
			mar_enable	<= '0';
		WHEN load_4	=>
			mdr_out		<= '1';
			g_ra		<= '1';
			r_enable	<= '1';
			mdr_enable	<= '0';
			read_ctrl	<= '0';
			
		-- LOAD IMMIDIATE
		WHEN load_i	=>
			g_rb		<= '1';
			r_out		<= '1';
			y_enable	<= '1';
		WHEN load_i_1	=>
			immid_val_out	<= '1';
			z_enable	<= '1';
			alu_code	<= "0000";
			g_rb		<= '0';
			r_out		<= '0';
			y_enable	<= '0';
		WHEN load_i_2	=>
			z_lo_out	<= '1';
			g_ra		<= '1';
			r_enable	<= '1';
			immid_val_out	<= '0';
			z_enable	<= '0';
			
		-- STORE
		WHEN store	=>
			g_rb		<= '1';
			r_out		<= '1';
			y_enable	<= '1';
		WHEN store_1	=>
			immid_val_out	<= '1';
			z_enable			<= '1';
			alu_code			<= "0000";
			g_rb				<= '0';
			r_out				<= '0';
			y_enable			<= '0';
		WHEN store_2	=>
			z_lo_out			<= '1';
			mar_enable		<= '1';
			immid_val_out	<= '0';
			z_enable			<= '0';
		WHEN store_3	=>
			g_ra				<=	'1';
			write_ctrl		<=	'1';
			r_out				<= '1';
			z_lo_out			<= '0';
			mar_enable		<= '0';
			
		-- ADD
		WHEN add	=>
			g_rb				<= '1';
			r_out				<= '1';
			y_enable			<= '1';
		WHEN add_1	=>
			g_rc				<= '1';
			r_out				<= '1';
			z_enable			<= '1';
			alu_code			<= "0000";
			g_rb				<= '0';
			y_enable			<= '0';
		WHEN add_2	=>
			z_lo_out			<= '1';
			g_ra				<= '1';
			r_enable			<= '1';
			g_rc				<= '0';
			r_out				<= '0';
			z_enable			<= '0';
			
		-- SUB
		WHEN sub	=>
			g_rb				<= '1';
			r_out				<= '1';
			y_enable			<= '1';
		WHEN sub_1	=>
			g_rc				<= '1';
			r_out				<= '1';
			z_enable			<= '1';
			alu_code			<= "0001";
			g_rb				<= '0';
			y_enable			<= '0';
		WHEN sub_2	=>
			z_lo_out			<= '1';
			g_ra				<= '1';
			r_enable			<= '1';
			g_rc				<= '0';
			r_out				<= '0';
			z_enable			<= '0';
			
		-- AND
		WHEN and_0	=>
			g_rb				<= '1';
			r_out				<= '1';
			y_enable			<= '1';
		WHEN and_1	=>
			g_rc				<= '1';
			r_out				<= '1';
			z_enable			<= '1';
			alu_code			<= "0100";
			g_rb				<= '0';
			y_enable			<= '0';
		WHEN and_2	=>
			z_lo_out			<= '1';
			g_ra				<= '1';
			r_enable			<= '1';
			g_rc				<= '0';
			r_out				<= '0';
			z_enable			<= '0';
			
		-- OR
		WHEN or_0	=>
			g_rb				<= '1';
			r_out				<= '1';
			y_enable			<= '1';
		WHEN or_1	=>
			g_rc				<= '1';
			r_out				<= '1';
			z_enable			<= '1';
			alu_code			<= "0101";
			g_rb				<= '0';
			y_enable			<= '0';
		WHEN or_2	=>
			z_lo_out			<= '1';
			g_ra				<= '1';
			r_enable			<= '1';
			g_rc				<= '0';
			r_out				<= '0';
			z_enable			<= '0';
			
		-- SHR
		WHEN shift_r	=>
			g_rb				<= '1';
			r_out				<= '1';
			y_enable			<= '1';
		WHEN shift_r_1	=>
			g_rc				<= '1';
			r_out				<= '1';
			z_enable			<= '1';
			alu_code			<= "0110";
			g_rb				<= '0';
			y_enable			<= '0';
		WHEN shift_r_2	=>
			z_lo_out			<= '1';
			g_ra				<= '1';
			r_enable			<= '1';
			g_rc				<= '0';
			r_out				<= '0';
			z_enable			<= '0';
			
		-- SHRA
		WHEN shift_r_a	=>
			g_rb				<= '1';
			r_out				<= '1';
			y_enable			<= '1';
		WHEN shift_r_a_1	=>
			g_rc				<= '1';
			r_out				<= '1';
			z_enable			<= '1';
			alu_code			<= "0111";
			g_rb				<= '0';
			y_enable			<= '0';
		WHEN shift_r_a_2	=>
			z_lo_out			<= '1';
			g_ra				<= '1';
			r_enable			<= '1';
			g_rc				<= '0';
			r_out				<= '0';
			z_enable			<= '0';
			
		-- SHL
		WHEN shift_l	=>
			g_rb				<= '1';
			r_out				<= '1';
			y_enable			<= '1';
		WHEN shift_l_1	=>
			g_rc				<= '1';
			r_out				<= '1';
			z_enable			<= '1';
			alu_code			<= "1000";
			g_rb				<= '0';
			y_enable			<= '0';
		WHEN shift_l_2	=>
			z_lo_out			<= '1';
			g_ra				<= '1';
			r_enable			<= '1';
			g_rc				<= '0';
			r_out				<= '0';
			z_enable			<= '0';
			
		-- ROR
		WHEN rotate_r	=>
			g_rb				<= '1';
			r_out				<= '1';
			y_enable			<= '1';
		WHEN rotate_r_1	=>
			g_rc				<= '1';
			r_out				<= '1';
			z_enable			<= '1';
			alu_code			<= "1000";
			g_rb				<= '0';
			y_enable			<= '0';
		WHEN rotate_r_2	=>
			z_lo_out			<= '1';
			g_ra				<= '1';
			r_enable			<= '1';
			g_rc				<= '0';
			r_out				<= '0';
			z_enable			<= '0';
			
		-- ROL
		WHEN rotate_l	=>
			g_rb				<= '1';
			r_out				<= '1';
			y_enable			<= '1';
		WHEN rotate_l_1	=>
			g_rc				<= '1';
			r_out				<= '1';
			z_enable			<= '1';
			alu_code			<= "1000";
			g_rb				<= '0';
			y_enable			<= '0';
		WHEN rotate_l_2	=>
			z_lo_out			<= '1';
			g_ra				<= '1';
			r_enable			<= '1';
			g_rc				<= '0';
			r_out				<= '0';
			z_enable			<= '0';
			
		-- ADD I
		WHEN add_i	=>
			g_rb				<= '1';
			r_out				<= '1';
			y_enable			<= '1';
		WHEN add_i_1	=>
			immid_val_out	<= '1';
			z_enable			<= '1';
			alu_code			<= "0000";
			r_out				<= '0';
			g_rb				<= '0';
			y_enable			<= '0';
		WHEN add_i_2	=>
			z_lo_out			<= '1';
			g_ra				<= '1';
			r_enable			<= '1';
			immid_val_out	<= '0';
			z_enable			<= '0';
			
		-- AND I
		WHEN and_i	=>
			g_rb				<= '1';
			r_out				<= '1';
			y_enable			<= '1';
		WHEN and_i_1	=>
			immid_val_out	<= '1';
			z_enable			<= '1';
			alu_code			<= "0100";
			r_out				<= '0';
			g_rb				<= '0';
			y_enable			<= '0';
		WHEN and_i_2	=>
			z_lo_out			<= '1';
			g_ra				<= '1';
			r_enable			<= '1';
			immid_val_out	<= '0';
			z_enable			<= '0';
			
		-- OR I
		WHEN or_i	=>
			g_rb				<= '1';
			r_out				<= '1';
			y_enable			<= '1';
		WHEN or_i_1	=>
			immid_val_out	<= '1';
			z_enable			<= '1';
			alu_code			<= "0101";
			r_out				<= '0';
			g_rb				<= '0';
			y_enable			<= '0';
		WHEN or_i_2	=>
			z_lo_out			<= '1';
			g_ra				<= '1';
			r_enable			<= '1';
			immid_val_out	<= '0';
			z_enable			<= '0';
			
		-- Branch
		WHEN branch	=>
			con_enable			<= '1';
			g_ra				<= '1';
			r_out				<= '1';
		WHEN branch_1	=>
			IF con_ff = '1' THEN
				immid_val_out	<= '1';
				pc_enable 	<= '1';
			END IF;
			con_enable		<= '0';
			g_ra				<= '0';
			r_out				<= '0';
		
		-- MULTIPLY
		WHEN mul	=>
			g_ra				<= '1';
			r_out				<= '1';
			y_enable			<= '1';
		WHEN mul_1	=>
			alu_code			<= "0010";
			g_rb				<= '1';
			z_enable			<= '1';
			g_ra				<= '0';
			y_enable			<= '0';
			r_out				<= '1';
		WHEN mul_2	=>
			z_hi_out			<= '1';
			hi_enable		<= '1';
			g_rb				<= '0';
			r_out				<= '0';
			z_enable			<= '0';
		WHEN mul_3	=>
			z_lo_out			<= '1';
			lo_enable		<= '1';
			z_hi_out			<= '0';
			hi_enable		<= '0';
		
		-- DIVIDE
		WHEN divide	=>
			g_ra				<= '1';
			r_out				<= '1';
			y_enable			<= '1';
		WHEN divide_1	=>
			alu_code			<= "0011";
			g_rb				<= '1';
			z_enable			<= '1';
			g_ra				<= '0';
			y_enable			<= '0';
			r_out				<= '1';
		WHEN divide_2	=>
			z_hi_out			<= '1';
			hi_enable		<= '1';
			g_rb				<= '0';
			r_out				<= '0';
			z_enable			<= '0';
		WHEN divide_3	=>
			z_lo_out			<= '1';
			lo_enable		<= '1';
			z_hi_out			<= '0';
			hi_enable		<= '0';
			
		-- NEGATE
		WHEN negate	=>
			alu_code			<= "1101";
			g_rb				<= '1';
			r_out				<= '1';
			z_enable			<= '1';
		WHEN negate_1	=>
			g_ra				<= '1';
			r_enable			<= '1';
			z_lo_out			<= '1';
			g_rb				<= '0';
			r_out				<= '0';
			z_enable			<= '0';
		WHEN negate_2	=>	
			z_hi_out			<= '1';
			hi_enable		<= '1';
			r_enable			<= '0';
			g_ra				<= '0';
			z_lo_out			<= '0';
			
		-- NOT
		WHEN not_0	=>
			alu_code			<= "1110";
			g_rb				<= '1';
			r_out				<= '1';
			z_enable			<= '1';
		WHEN not_1	=>
			g_ra				<= '1';
			r_enable			<= '1';
			z_lo_out			<= '1';
			g_rb				<= '0';
			r_out				<= '0';
			z_enable			<= '0';
		WHEN not_2	=>	
			z_hi_out			<= '1';
			hi_enable		<= '1';
			r_enable			<= '0';
			g_ra				<= '0';
			z_lo_out			<= '0';
			
		WHEN jr		=>
			pc_enable		<=	'1';
			r_out			<=	'1';
			g_ra				<= '1';
			
		WHEN jal		=>
			pc_out			<=	'1';
			g_rb				<= '1';
			r_enable			<=	'1';
		WHEN jal_1		=>
			pc_enable		<=	'1';
			r_out				<=	'1';
			g_ra				<= '1';
			pc_out			<=	'0';
			g_rb				<= '0';
			r_enable			<=	'0';
			
		WHEN mfhi		=>
			r_enable		<= '1';
			g_ra				<= '1';
			hi_out			<= '1';
			
		WHEN mflo		=>
			r_enable		<= '1';
			g_ra				<= '1';
			lo_out			<= '1';
			
		WHEN input		=>
			r_enable		<= '1';
			g_ra				<= '1';
			in_port_out		<= '1';
			
		WHEN output		=>
			r_out		<= '1';
			g_ra		<= '1';
			out_port_en	<= '1';
			
		WHEN nop =>
			
		WHEN halt =>
			
			
			
		WHEN OTHERS =>
		END CASE;
	END PROCESS;
END ARCHITECTURE;

