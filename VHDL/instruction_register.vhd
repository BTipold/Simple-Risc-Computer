LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY instruction_register IS 
	PORT(
		D	: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		opcode	: OUT STD_LOGIC_VECTOR(4  DOWNTO 0);
		ra	: OUT STD_LOGIC_VECTOR(3  DOWNTO 0);
		rb	: OUT STD_LOGIC_VECTOR(3  DOWNTO 0);
		rc	: OUT STD_LOGIC_VECTOR(3  DOWNTO 0);
		value_i	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		en  	: IN  STD_LOGIC;
		clk 	: IN  STD_LOGIC;
		clr 	: IN  STD_LOGIC
	);
END instruction_register;

ARCHITECTURE arch OF instruction_register IS
BEGIN
	PROCESS(clk, clr, en, D)
	BEGIN
		IF (clr = '1') THEN
			opcode 	<= "00000";
			ra	<= "0000";
			rb	<= "0000";
			rc	<= "0000";
			value_i	<= x"00000000";
		ELSIF (rising_edge(clk)) THEN
			IF (en = '1') THEN
				opcode	<= D(31 DOWNTO 27);
				ra	<= D(26 DOWNTO 23);
				rb	<= D(22 DOWNTO 19);
				rc	<= D(18 DOWNTO 15);

				-- Sign Extension
				IF (D(18) = '1') THEN
					value_i <= x"FFFFFFFF";
				ELSE
					value_i <= x"00000000";
				END IF;
				value_i(18 DOWNTO 0) <= D(18 DOWNTO 0);
			END IF;	
		END IF;
	END PROCESS;
END arch;	
		
