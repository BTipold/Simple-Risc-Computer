LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY mux_2to1 IS 
	PORT(
		A	: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);	
		B	: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);		
		sel	: IN  STD_LOGIC;
		output 	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)	
	);
END mux_2to1;

ARCHITECTURE arch OF mux_2to1 IS		
BEGIN
	WITH sel SELECT
		output <=	A WHEN '0',
				B WHEN OTHERS;
end arch;
