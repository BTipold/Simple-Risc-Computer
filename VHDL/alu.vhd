library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity alu is 
	port(
		A		  : in  STD_LOGIC_VECTOR(31 downto 0);
		B		  : in  STD_LOGIC_VECTOR(31 downto 0);
		op_code : in  STD_LOGIC_VECTOR(3  downto 0);
		C		  : out STD_LOGIC_VECTOR(63 downto 0)
	);
end alu;

architecture arch of alu is

signal temp : STD_LOGIC_VECTOR(31 downto 0);

begin
	process(A, B, op_code, temp)
	begin
		temp <= x"00000000";
		
		-- ADD
		if		(op_code = "0000") then
			temp <= STD_LOGIC_VECTOR(UNSIGNED(A) + UNSIGNED(B));
			C	  <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(temp), C'length));
			
		-- SUB
		elsif (op_code = "0001") then
			temp <= STD_LOGIC_VECTOR(UNSIGNED(A) - UNSIGNED(B));
			C	  <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(temp), C'length));
			
		-- MUL
		elsif (op_code = "0010") then
			C <= STD_LOGIC_VECTOR(UNSIGNED(A) * UNSIGNED(B));
			
		-- DIV
		elsif (op_code = "0011") then
			temp <= STD_LOGIC_VECTOR(UNSIGNED(A) / UNSIGNED(B));
			C	  <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(temp), C'length));
			temp <= STD_LOGIC_VECTOR(UNSIGNED(A) REM UNSIGNED(B));
			C(63 DOWNTO 32)	  <= temp;
			
		-- AND
		elsif (op_code = "0100") then
			temp <= STD_LOGIC_VECTOR(UNSIGNED(A) AND UNSIGNED(B));
			C	  <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(temp), C'length));
			
		-- OR
		elsif (op_code = "0101") then
			temp <= STD_LOGIC_VECTOR(SIGNED(A) OR SIGNED(B));
			C	  <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(temp), C'length));
			
		-- SHIFT RIGHT LOGICAL
		elsif (op_code = "0110") then
			temp <= TO_STDLOGICVECTOR(TO_BITVECTOR(A) SRL TO_INTEGER(SIGNED(B)));
			C	  <= STD_LOGIC_VECTOR(RESIZE(SIGNED(temp), C'length));
			
		-- SHIFT RIGHT ARITHMETIC
		elsif (op_code = "0111") then
			temp <= TO_STDLOGICVECTOR(TO_BITVECTOR(A) SRA TO_INTEGER(SIGNED(B)));
			C	  <= STD_LOGIC_VECTOR(RESIZE(SIGNED(temp), C'length));
			
		-- SHIFT LEFT LOGICAL
		elsif (op_code = "1000") then
			temp <= TO_STDLOGICVECTOR(TO_BITVECTOR(A) SLL TO_INTEGER(SIGNED(B)));
			C	  <= STD_LOGIC_VECTOR(RESIZE(SIGNED(temp), C'length));
			
		-- SHIFT LEFT ARITHMETIC
		elsif (op_code = "1001") then
			temp <= TO_STDLOGICVECTOR(TO_BITVECTOR(A) SLA TO_INTEGER(SIGNED(B)));
			C	  <= STD_LOGIC_VECTOR(RESIZE(SIGNED(temp), C'length));
			
		-- ROTATE RIGHT
		elsif (op_code = "1010") then
			temp <= TO_STDLOGICVECTOR(TO_BITVECTOR(A) ROR TO_INTEGER(SIGNED(B)));
			C	  <= STD_LOGIC_VECTOR(RESIZE(SIGNED(temp), C'length));
			
		-- ROTATE LEFT
		elsif (op_code = "1011") then
			temp <= TO_STDLOGICVECTOR(TO_BITVECTOR(A) ROL TO_INTEGER(SIGNED(B)));
			C	  <= STD_LOGIC_VECTOR(RESIZE(SIGNED(temp), C'length));
			
		-- PC INC
		elsif (op_code = "1100") then
			temp <= STD_LOGIC_VECTOR(SIGNED(B) + 1);
			C	  <= STD_LOGIC_VECTOR(RESIZE(SIGNED(temp), C'length));
			
		-- NEGATE
		elsif (op_code = "1101") then
			temp <= STD_LOGIC_VECTOR(-SIGNED(B));
			C	  <= STD_LOGIC_VECTOR(RESIZE(SIGNED(temp), C'length));
			
		-- NOT
		elsif (op_code = "1110") then
			temp <= NOT(B);
			C	  <= STD_LOGIC_VECTOR(RESIZE(SIGNED(temp), C'length));
			
		else
			C <= STD_LOGIC_VECTOR(RESIZE(SIGNED(A), C'length));
		end if;
	end process;
end arch;

		