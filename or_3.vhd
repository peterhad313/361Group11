library ieee;
use ieee.std_logic_1164.all;

-- 3-input or gate

entity or_3 is
 
  port (
    	a   : in  std_logic;
    	b   : in  std_logic;
    	c   : in std_logic;
	z   : out std_logic
  );
end or_3;

architecture structural of or_3 is
signal or1 : std_logic;

component or_gate is
  port (
    x   : in  std_logic;
    y   : in  std_logic;
    z   : out std_logic
  );
end component;


begin
or1_map: or_gate port map (x => a, y => b, z => or1);
or2_map: or_gate port map (x => or1, y => c, z => z);
end architecture structural;