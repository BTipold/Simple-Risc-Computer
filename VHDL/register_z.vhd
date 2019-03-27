LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

-- ENTITY DECLARATION
ENTITY register_z IS 
	PORT(
		alu_out : IN  STD_LOGIC_VECTOR(63 DOWNTO 0);
		z_lo	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		z_hi	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		z_en	: IN  STD_LOGIC;
		clock	: IN  STD_LOGIC;
		clear	: IN  STD_LOGIC
	);
END register_z;


-- ARHCITECTURE
ARCHITECTURE arch OF register_z IS

-- CREATE A 32 BIT REGISTER COMPONENT
COMPONENT register_32
	PORT(
		D   : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		q   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		en  : IN  STD_LOGIC;
		clk : IN  STD_LOGIC;
		clr : IN  STD_LOGIC
	);
END COMPONENT;

--SIGNALS
SIGNAL upper_bits : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL lower_bits : STD_LOGIC_VECTOR(31 DOWNTO 0);

--CREATE ARCHITECTURE
BEGIN
	upper_bits <= alu_out(63 DOWNTO 32);
	lower_bits <= alu_out(31 DOWNTO 0);
	z_hi_reg : register_32
	PORT MAP (
		D   => upper_bits,
		Q   => z_hi,
		en  => z_en,
		clk => clock,
		clr => clear
	);
		
	z_lo_reg : register_32
	PORT MAP (
		D    => lower_bits,
		Q    => z_lo,
		en   => z_en,
		clk  => clock,
		clr  => clear
	);
END arch;	
		
