library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- ENTITY DECLARATION
entity register_z is 
	port(
		alu_out : in  STD_LOGIC_VECTOR(63 downto 0);
		z_lo	  : out STD_LOGIC_VECTOR(31 downto 0);
		z_hi	  : out STD_LOGIC_VECTOR(31 downto 0);
		z_en    : in  STD_LOGIC;
		clock	  : in  STD_LOGIC;
		clear	  : in  STD_LOGIC
	);
end register_z;


-- ARHCITECTURE
architecture arch of register_z is

-- CREATE A 32 BIT REGISTER COMPONENT
component register_32
	port(
		D	 : in  STD_LOGIC_VECTOR(31 downto 0);
		q	 :	out STD_LOGIC_VECTOR(31 downto 0);
		en  : in  STD_LOGIC;
		clk :	in	 STD_LOGIC;
		clr : in  STD_LOGIC
	);
end component;

--SIGNALS
signal upper_bits : STD_LOGIC_VECTOR(31 downto 0);
signal lower_bits : STD_LOGIC_VECTOR(31 downto 0);

--CREATE ARCHITECTURE
begin
	upper_bits <= alu_out(63 downto 32);
	lower_bits <= alu_out(31 downto 0);
	z_hi_reg : register_32 port map (D=>upper_bits, Q=>z_hi, en=>z_en, clk=>clock, clr=>clear);
	z_lo_reg : register_32 port map (D=>lower_bits, Q=>z_lo, en=>z_en, clk=>clock, clr=>clear);
end arch;	
		