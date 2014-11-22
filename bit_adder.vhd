library ieee;
use ieee.std_logic_1164.all;

entity bit_adder is
	port (
		a,b,cin: in std_logic;
		sum,cout: out std_logic
	);
end bit_adder;

architecture struct of bit_adder is
	signal x,y,z: std_logic;
begin
	xor1: entity work.xor_gate
		port map (x=>a,y=>b,z=>x);
	xor2: entity work.xor_gate
		port map (x=>x,y=>cin,z=>sum);
	and1: entity work.and_gate
		port map (x=>x,y=>cin,z=>y);
	and2: entity work.and_gate
		port map (x=>a,y=>b,z=>z);
	or1: entity work.or_gate
		port map (x=>y,y=>z,z=>cout);
end struct;