library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_zero is 
	port(
		D	 		: IN  STD_LOGIC_VECTOR(31 downto 0);
		q	 		: OUT STD_LOGIC_VECTOR(31 downto 0);
		en  		: IN  STD_LOGIC;
		clk 		: IN	STD_LOGIC;
		clr 		: IN  STD_LOGIC
	);
end register_zero;

architecture arch of register_zero is
begin
	process(clk, clr, en)
	begin
		q	<= x"00000000";
	end process;
end arch;	

