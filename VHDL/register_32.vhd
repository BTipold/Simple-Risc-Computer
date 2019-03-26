library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity register_32 is 
	port(
		D	 : in  STD_LOGIC_VECTOR(31 downto 0);
		q	 :	out STD_LOGIC_VECTOR(31 downto 0);
		en  : in  STD_LOGIC;
		clk :	in	 STD_LOGIC;
		clr : in  STD_LOGIC
	);
end register_32;

architecture arch of register_32 is
begin
	process(clk, clr, en)
	begin
		if(clr = '1') then
			q <= x"00000000";
		elsif(rising_edge(clk)) then
			if(en = '1') then
				q <= D;
			end if;
		end if;
	end process;
end arch;	
		