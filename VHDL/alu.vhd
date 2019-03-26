LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.all;

ENTITY alu IS 
	PORT(
		A	: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		B	: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		op_code : IN  STD_LOGIC_VECTOR(3  DOWNTO 0);
		C	: OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
	);
END alu;

ARCHITECTURE arch OF alu IS

SIGNAL temp : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN
	PROCESS(A, B, op_code, temp)
	BEGIN
		temp <= x"00000000";
		
		-- ADD
		IF (op_code = "0000") THEN
			temp 	<= STD_LOGIC_VECTOR(UNSIGNED(A) + UNSIGNED(B));
			C	<= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(temp), C'length));
			
		-- SUB
		ELSIF (op_code = "0001") THEN
			temp 	<= STD_LOGIC_VECTOR(UNSIGNED(A) - UNSIGNED(B));
			C	<= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(temp), C'length));
			
		-- MUL
		ELSIF (op_code = "0010") THEN
			C 	<= STD_LOGIC_VECTOR(UNSIGNED(A) * UNSIGNED(B));
			
		-- DIV
		ELSIF (op_code = "0011") THEN
			temp 	<= STD_LOGIC_VECTOR(UNSIGNED(A) / UNSIGNED(B));
			C	<= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(temp), C'length));
			temp 	<= STD_LOGIC_VECTOR(UNSIGNED(A) REM UNSIGNED(B));
			C(63 DOWNTO 32)	<= temp;
			
		-- AND
		ELSIF (op_code = "0100") THEN
			temp 	<= STD_LOGIC_VECTOR(UNSIGNED(A) AND UNSIGNED(B));
			C	<= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(temp), C'length));
			
		-- OR
		ELSIF (op_code = "0101") THEN
			temp 	<= STD_LOGIC_VECTOR(SIGNED(A) OR SIGNED(B));
			C	<= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(temp), C'length));
			
		-- SHIFT RIGHT LOGICAL
		ELSIF (op_code = "0110") THEN
			temp 	<= TO_STDLOGICVECTOR(TO_BITVECTOR(A) SRL TO_INTEGER(SIGNED(B)));
			C	<= STD_LOGIC_VECTOR(RESIZE(SIGNED(temp), C'length));
			
		-- SHIFT RIGHT ARITHMETIC
		ELSIF (op_code = "0111") THEN
			temp 	<= TO_STDLOGICVECTOR(TO_BITVECTOR(A) SRA TO_INTEGER(SIGNED(B)));
			C	<= STD_LOGIC_VECTOR(RESIZE(SIGNED(temp), C'length));
			
		-- SHIFT LEFT LOGICAL
		ELSIF (op_code = "1000") THEN
			temp 	<= TO_STDLOGICVECTOR(TO_BITVECTOR(A) SLL TO_INTEGER(SIGNED(B)));
			C	<= STD_LOGIC_VECTOR(RESIZE(SIGNED(temp), C'length));
			
		-- SHIFT LEFT ARITHMETIC
		ELSIF (op_code = "1001") THEN
			temp 	<= TO_STDLOGICVECTOR(TO_BITVECTOR(A) SLA TO_INTEGER(SIGNED(B)));
			C	<= STD_LOGIC_VECTOR(RESIZE(SIGNED(temp), C'length));
			
		-- ROTATE RIGHT
		ELSIF (op_code = "1010") THEN
			temp 	<= TO_STDLOGICVECTOR(TO_BITVECTOR(A) ROR TO_INTEGER(SIGNED(B)));
			C	<= STD_LOGIC_VECTOR(RESIZE(SIGNED(temp), C'length));
			
		-- ROTATE LEFT
		ELSIF (op_code = "1011") THEN
			temp 	<= TO_STDLOGICVECTOR(TO_BITVECTOR(A) ROL TO_INTEGER(SIGNED(B)));
			C	<= STD_LOGIC_VECTOR(RESIZE(SIGNED(temp), C'length));
			
		-- PC INC
		ELSIF (op_code = "1100") THEN
			temp 	<= STD_LOGIC_VECTOR(SIGNED(B) + 1);
			C	<= STD_LOGIC_VECTOR(RESIZE(SIGNED(temp), C'length));
			
		-- NEGATE
		ELSIF (op_code = "1101") THEN
			temp 	<= STD_LOGIC_VECTOR(-SIGNED(B));
			C	<= STD_LOGIC_VECTOR(RESIZE(SIGNED(temp), C'length));
			
		-- NOT
		ELSIF (op_code = "1110") THEN
			temp	<= NOT(B);
			C 	<= STD_LOGIC_VECTOR(RESIZE(SIGNED(temp), C'length));
			
		ELSE
			C	<= STD_LOGIC_VECTOR(RESIZE(SIGNED(A), C'length));
		END IF;
	END PROCESS;
END arch;

		
