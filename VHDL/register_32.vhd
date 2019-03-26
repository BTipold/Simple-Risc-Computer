LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY register_32 IS 
	PORT(
		D	: IN  STD_LOGIC_VECTOR(31 downto 0);
		q	: OUT STD_LOGIC_VECTOR(31 downto 0);
		en  	: IN  STD_LOGIC;
		clk 	: IN  STD_LOGIC;
		clr 	: IN  STD_LOGIC
	);
END register_32;

ARCHITECTURE arch OF register_32 IS
BEGIN
	PROCESS(clk, clr, en)
	BEGIN
		IF(clr = '1') THEN
			q <= x"00000000";
		ELSIF(rising_edge(clk)) THEN
			IF(en = '1') THEN
				q <= D;
			END IF;
		END IF;
	END PROCESS;
END arch;	
		
