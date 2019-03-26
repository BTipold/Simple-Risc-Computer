LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY bus_mux IS 
	PORT(
		pc_in		  : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r0_in 	  : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r1_in 	  : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r2_in 	  : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r3_in 	  : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r4_in 	  : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r5_in 	  : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r6_in 	  : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r7_in 	  : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r8_in 	  : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r9_in 	  : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r10_in 	  : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r11_in 	  : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r12_in 	  : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r13_in	  : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r14_in 	  : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r15_in 	  : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		hi_in 	  : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		lo_in		  : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		mdr_in	  : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		inport_in  : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		immid_val  : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		z_hi_in	  : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		z_lo_in	  : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		sel	 	  : IN  STD_LOGIC_VECTOR(4  DOWNTO 0);
		r_out	 	  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)	
	);
END bus_mux;

ARCHITECTURE arch OF bus_mux IS
BEGIN
	WITH sel SELECT
		r_out <= r0_in 	 WHEN "00000",
					r1_in 	 WHEN "00001",
					r2_in 	 WHEN "00010",
					r3_in 	 WHEN "00011",
					r4_in 	 WHEN "00100",
					r5_in 	 WHEN "00101",
					r6_in 	 WHEN "00110",
					r7_in 	 WHEN "00111",
					r8_in 	 WHEN "01000",
					r9_in 	 WHEN "01001",
					r10_in 	 WHEN "01010",
					r11_in 	 WHEN "01011",
					r12_in 	 WHEN "01100",
					r13_in 	 WHEN "01101",
					r14_in 	 WHEN "01110",
					r15_in 	 WHEN "01111",
					
					hi_in 	 WHEN "10000",
					lo_in 	 WHEN "10001",
					pc_in 	 WHEN "10010",
					mdr_in 	 WHEN "10011",
					z_hi_in	 WHEN "10100",
					z_lo_in	 WHEN "10101",
					immid_val WHEN "10110",
					inport_in WHEN OTHERS;
END arch;