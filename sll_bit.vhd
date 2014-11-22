library ieee;
use ieee.std_logic_1164.all;

entity sll_bit is
	port (
		cin		: in std_logic;
		a		: in std_logic;
		cout	: out std_logic;
		R		: out std_logic
	);
end sll_bit;

architecture struct of sll_bit is
begin
	cout <= a;
	R <= cin;
end struct;