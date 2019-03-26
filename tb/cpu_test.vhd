-- SIMPLE RISC COMPUTER
-- Property of Brian Tipold
-- For Queen's University comp eng course ELEC 374


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE behavior OF testbench IS 
COMPONENT data_path
	PORT
	(	
		clock_in			: IN  STD_LOGIC;
		stop_in			: IN STD_LOGIC;
		run_out			: OUT STD_LOGIC;
		reset_in			: IN STD_LOGIC;
		
		in_port			: IN	STD_LOGIC_VECTOR(31 DOWNTO 0);
		out_port			: OUT	STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;
          
SIGNAL clk			: STD_LOGIC;
SIGNAL stop_sig	: STD_LOGIC;
SIGNAL run_sig		: STD_LOGIC;
SIGNAL reset_sig	: STD_LOGIC;
SIGNAL in_data		: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL out_data	: STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN

DUT: data_path
PORT MAP(
			clock_in => clk,
			stop_in	=>	stop_sig,
			run_out  =>	run_sig,
			reset_in	=>	reset_sig,
			
			in_port	=>	in_data,
			out_port	=>	out_data
);	


clock_process: PROCESS IS
BEGIN
	clk <= '1';
	wait for 10 ns;
	clk <= '0';
	wait for 10 ns;
END PROCESS clock_process;

stop_sig <= '0';
reset_sig <= '0';
in_data <= x"00000000";
out_data <= x"00000000";

END ARCHITECTURE;
