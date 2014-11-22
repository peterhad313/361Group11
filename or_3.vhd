library ieee;
use ieee.std_logic_1164.all;

-- 3-input or gate

entity big_or is
 
  port (
    	a   : in  std_logic;
    	b   : in  std_logic;
    	c   : in std_logic;
	z   : out std_logic;
  );
end big_or;

architecture structural of big_or is
signal or1 : std_logic;

begin
or1_map: or_gate port map (x => a, y => b, z => or1);
or2_map: or_gate port map (x => or1, y => c, z => z);
end architecture structural;