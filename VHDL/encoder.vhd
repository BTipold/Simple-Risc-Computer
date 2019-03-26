LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY encoder IS
	PORT(
		ROout			: IN  STD_LOGIC;
		R1out			: IN  STD_LOGIC;
		R2out			: IN  STD_LOGIC;
		R3out			: IN  STD_LOGIC;
		R4out			: IN  STD_LOGIC;
		R5out			: IN  STD_LOGIC;
		R6out			: IN  STD_LOGIC;
		R7out			: IN  STD_LOGIC;
		R8out			: IN  STD_LOGIC;
		R9out			: IN  STD_LOGIC;
		R10out		: IN  STD_LOGIC;
		R11out		: IN  STD_LOGIC;
		R12out		: IN  STD_LOGIC;
		R13out		: IN  STD_LOGIC;
		R14out		: IN  STD_LOGIC;
		R15out		: IN  STD_LOGIC;
		HIout			: IN  STD_LOGIC;
		LOout			: IN  STD_LOGIC;
		PCout			: IN  STD_LOGIC;
		ZHiOut		: IN  STD_LOGIC;
		ZLoOut		: IN  STD_LOGIC;
		MDRout		: IN  STD_LOGIC;
		INPortOut	: IN  STD_LOGIC;
		immid_val   : IN  STD_LOGIC;
		
		encoder_out	: OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
END encoder;

ARCHITECTURE arch OF encoder IS
BEGIN
	process(	ROout, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out,
				R9out, R10out, R11out, R12out, R13out, R14out, R15out, HIout, 
				LOout, ZLoOut, ZHiOut, PCout, MDRout, INPortOut, immid_val)
	BEGIN
		IF		(ROout = '1') 		THEN encoder_out <= "00000";
		ELSIF (R1out = '1') 		THEN encoder_out <= "00001";
		ELSIF (R2out = '1') 		THEN encoder_out <= "00010";
		ELSIF (R3out = '1') 		THEN encoder_out <= "00011";
		ELSIF (R4out = '1') 		THEN encoder_out <= "00100";
		ELSIF (R5out = '1') 		THEN encoder_out <= "00101";
		ELSIF (R6out = '1') 		THEN encoder_out <= "00110";
		ELSIF (R7out = '1') 		THEN encoder_out <= "00111";
		ELSIF (R8out = '1') 		THEN encoder_out <= "01000";
		ELSIF (R9out = '1') 		THEN encoder_out <= "01001";
		ELSIF (R10out = '1') 	THEN encoder_out <= "01010";
		ELSIF (R11out = '1')		THEN encoder_out <= "01011";
		ELSIF (R12out = '1') 	THEN encoder_out <= "01100";
		ELSIF (R13out = '1')		THEN encoder_out <= "01101";
		ELSIF (R14out = '1') 	THEN encoder_out <= "01110";
		ELSIF (R15out = '1') 	THEN encoder_out <= "01111";
		
		ELSIF (HIout = '1') 		THEN encoder_out <= "10000";
		ELSIF (LOout = '1') 		THEN encoder_out <= "10001";
		ELSIF (PCout = '1') 		THEN encoder_out <= "10010";
		ELSIF (MDRout = '1') 	THEN encoder_out <= "10011";
		ELSIF (ZHiOut = '1') 	THEN encoder_out <= "10100";
		ELSIF (ZLoOut = '1') 	THEN encoder_out <= "10101";
		ELSIF (immid_val = '1')	THEN encoder_out <= "10110";
		ELSIF (INPortOut = '1') THEN encoder_out <= "10111";
		ELSE								  encoder_out <= "11111";
		END IF;
	END PROCESS;
END arch;
