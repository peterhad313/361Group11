library ieee;
use ieee.std_logic_1164.all;

-- 8 input and gate

entity and_8 is

  port (
  a   : in  std_logic;
	b   : in  std_logic;
	c   : in  std_logic;
	d   : in  std_logic;
	e   : in  std_logic;
	f   : in  std_logic;
  g   : in std_logic;
  h   : in std_logic;
	z   : out std_logic
  );
end and_8;

architecture structural of and_8 is

signal and1_1 : std_logic;
signal and1_2 : std_logic;
signal and1_3 : std_logic;
signal and1_4 : std_logic;
signal and2_1: std_logic;
signal and2_2: std_logic;


component and_gate is
  port (
    x   : in  std_logic;
    y   : in  std_logic;
    z   : out std_logic
  );
end component;

begin
and1_1_map: and_gate port map (x => a, y => b, z => and1_1);
and1_2_map: and_gate port map (x => c, y => d, z => and1_2);  
and1_3_map: and_gate port map (x => e, y => f, z => and1_3);
and1_4_map: and_gate port map (g,h,and1_4);
and2_1_map: and_gate port map (and1_1, and1_2, and2_1);
and2_2_map: and_gate port map (and1_3, and1_4, and2_2);  
and3_map: and_gate port map (x => and2_1, y => and2_2, z => z);   

end architecture structural;
