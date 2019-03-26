LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE STD.textio.all;
USE IEEE.std_logic_textio.all;

ENTITY ram_module IS
	PORT
	(
		address	: IN STD_LOGIC_VECTOR (8 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		rden		: IN STD_LOGIC  := '1';
		wren		: IN STD_LOGIC ;
		q			: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END ram_module;

ARCHITECTURE arch OF ram_module IS
	-- SIGNALS
	TYPE mem IS ARRAY (511 DOWNTO 0) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL memory	: mem;
	SIGNAL addr		: INTEGER RANGE 0 TO 511;
	
	-- FILE IO
	FILE memory_file 	: TEXT;
	CONSTANT c_width		: NATURAL := 4;	
	
	BEGIN
		main_proc: PROCESS(clock, rden, wren, address)
			VARIABLE new_line	: LINE;
			VARIABLE instr		: STD_LOGIC_VECTOR(31 DOWNTO 0);
			VARIABLE	i			: INTEGER := 0;
			VARIABLE init	: STD_LOGIC := '1';
		BEGIN
			---------------INIT MEMORY---------------------------
			IF init = '1' THEN
				FILE_OPEN(memory_file, "../Memory/init.memory", read_mode);
				WHILE NOT ENDFILE(memory_file) LOOP
					READLINE(memory_file, new_line);
					READ(new_line, instr);
					memory(i) <= instr;
					i := i + 1;
				END LOOP;
				FILE_CLOSE(memory_file);
				init := '0';
			END IF;
			-----------------------------------------------------
			addr	<= CONV_INTEGER(address);
			IF wren = '1' THEN
				memory(addr) <= data;
			ELSIF rden = '1' THEN
				q <= memory(addr);
			END IF;
		END PROCESS;
END ARCHITECTURE;



