library ieee;
use ieee.std_logic_1164.all;
use work.mux_n;

entity mux_5 is
	port (
		sel : in std_logic;
		src0: in std_logic_vector(4 downto 0);
		src1: in std_logic_vector(4 downto 0);
		z	: out std_logic_vector(4 downto 0)
	);
end mux_5;

architecture struct of mux_5 is
begin
	mux_map: entity work.mux_n
		generic map (n=>5)
		port map (sel=>sel, src0=>src0, src1=>src1, z=>z);
end struct;