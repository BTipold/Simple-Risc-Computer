LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;

ENTITY conditional_logic IS
	PORT(
		c2_field : IN  STD_LOGIC_VECTOR(3  DOWNTO 0);
		con_in	 : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		con_en	 : IN	STD_LOGIC;
		con_out	 : OUT	STD_LOGIC
	);
END conditional_logic;

ARCHITECTURE arch OF conditional_logic IS
BEGIN
	PROCESS(c2_field, con_in, con_en)
	VARIABLE i : INTEGER;
	BEGIN
		IF SIGNED(c2_field) < 2 THEN		-- IF CHECKING 0 or NOT 0
			IF SIGNED(con_in) = 0 THEN	-- IF 0
				i := 0;			-- i = 0
			ELSIF SIGNED(con_in) /= 0 THEN	-- IF NOT 0
				i := 1;			-- i = 1
			ELSE
				i := -1;
			END IF;
		ELSE					-- IF CHECKING + or -
			IF SIGNED(con_in) > 0 THEN	-- IF POS
				i := 2;			-- i = 2
			ELSIF SIGNED(con_in) < 0 THEN	-- IF NEG
				i := 3;			-- i = 3
			ELSE
				i := -1;
			END IF;
		END IF;
		
		IF i = SIGNED(c2_field) THEN		-- IF C2 FIELD = i
			IF con_en = '1' THEN		-- AND ENABLED
				con_out <= '1';		-- SET CON OUT
			END IF;
		ELSE
			IF con_en = '1' THEN
				con_out <= '0';
			END IF;
		END IF;		
	END PROCESS;
END arch;
