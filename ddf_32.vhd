library ieee;
use ieee.std_logic_1164.all;

entity ddf_32 is 
  port(
    clock : in std_logic;
    input : in std_logic_vector(31 downto 0);
    output: out std_logic_vector(31 downto 0)
  );
end ddf_32;

architecture struct of ddf_32 is
  
  component dff is
  port (
	clk	: in  std_logic;
	d	: in  std_logic;
	q	: out std_logic:='0'
  );
end component;
  
begin
  
	  dff0: dff port map (clock,input(0),output(0));
    dff1: dff port map (clock,input(1),output(1));
    dff2: dff port map (clock,input(2),output(2));
    dff3: dff port map (clock,input(3),output(3));
    dff4: dff port map (clock,input(4),output(4));
    dff5: dff port map (clock,input(5),output(5));
    dff6: dff port map (clock,input(6),output(6));
    dff7: dff port map (clock,input(7),output(7));
    dff8: dff port map (clock,input(8),output(8));
    dff9: dff port map (clock,input(9),output(9));
    dff10: dff port map (clock,input(10),output(10));
    dff11: dff port map (clock,input(11),output(11));
    dff12: dff port map (clock,input(12),output(12));
    dff13: dff port map (clock,input(13),output(13));
    dff14: dff port map (clock,input(14),output(14));
    dff15: dff port map (clock,input(15),output(15));
    dff16: dff port map (clock,input(16),output(16));
    dff17: dff port map (clock,input(17),output(17));
    dff18: dff port map (clock,input(18),output(18));
    dff19: dff port map (clock,input(19),output(19));
    dff20: dff port map (clock,input(20),output(20));
    dff21: dff port map (clock,input(21),output(21));
    dff22: dff port map (clock,input(22),output(22));
    dff23: dff port map (clock,input(23),output(23));
    dff24: dff port map (clock,input(24),output(24));
    dff25: dff port map (clock,input(25),output(25));
    dff26: dff port map (clock,input(26),output(26));
    dff27: dff port map (clock,input(27),output(27));
    dff28: dff port map (clock,input(28),output(28));
    dff29: dff port map (clock,input(29),output(29));
    dff30: dff port map (clock,input(30),output(30));
    dff31: dff port map (clock,input(31),output(31));
  
end struct;