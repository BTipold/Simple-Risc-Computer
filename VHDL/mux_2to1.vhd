library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux_2to1 is 
	port(
		A	 	 : in  STD_LOGIC_VECTOR(31 downto 0);	
		B	 	 : in  STD_LOGIC_VECTOR(31 downto 0);		
		sel	 : in  STD_LOGIC;
		output : out STD_LOGIC_VECTOR(31 downto 0)	
	);
end mux_2to1;

architecture arch of mux_2to1 is		
begin
	with sel select
		output <= 	A when '0',
						B when others;
end arch;