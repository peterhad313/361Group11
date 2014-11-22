library ieee;
use ieee.std_logic_1164.all;

entity adder_32 is
	port (
		A,B	: in std_logic_vector(31 downto 0);
		sum	: out std_logic_vector(31 downto 0);
		cout: out std_logic
	);
end adder_32;

architecture struct of adder_32 is
	signal ctemp: std_logic_vector(31 downto 0);

begin
	ADD0: entity work.bit_adder
		port map(
			a=>A(0), b=>B(0), cin=>0, sum=>sum(0), cout=>ctemp(0)
		);
		
	Gen_ADD:
	for i in 1 to 30 generate
		ADDX: entity work.bit_adder
			port map(
				a=>A(i), b=>B(i), cin=>ctemp(i-1), sum=>sum(i), cout=>ctemp(i)
			);
	end generate;
	
	ADD31: entity work.bit_adder
		port map(
			a=>A(31), b=>B(31), cin=>ctemp(30), sum=>sum(31), cout=>cout
		);
end struct;