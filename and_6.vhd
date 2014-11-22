library ieee;
use ieee.std_logic_1164.all;

-- 6 input and gate

entity big_and is

  port (
   	a   : in  std_logic;
	b   : in  std_logic;
	c   : in  std_logic;
	d   : in  std_logic;
	e   : in  std_logic;
	f   : in  std_logic;
	z   : out std_logic;
  );
end big_and;

architecture structural of big_and is

signal and1_1 : std_logic;
signal and1_2 : std_logic;
signal and1_3 : std_logic;
signal and2: std_logic;

begin
and1_1_map: and_gate port map (x => a, y => b, z => and1_1);
and1_2_map: and_gate port map (x => c, y => d, z => and1_2);  
and1_3_map: and_gate port map (x => e, y => f, z => and1_3);  
and2_map: and_gate port map (x => and1_1, y => and1_2, z => and2); 
and3_map: and_gate port map (x => and1_3, y => and2, z => z);   

end architecture structural;
