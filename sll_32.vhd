
library ieee;
use ieee.std_logic_1164.all;

entity sll_32 is
  port (
    x   : in  std_logic_vector(31 downto 0);
    y   : in  std_logic_vector(31 downto 0);  -- only bottom five will be used --
    z   : out std_logic_vector(31 downto 0)
  );
end sll_32;

architecture struct of sll_32 is
component mux is
  port (
	sel	  : in	std_logic;
	src0  :	in	std_logic;
	src1  :	in	std_logic;
	z	  : out std_logic
  );
end component;
  signal row5 : std_logic_vector (31 downto 0);
  signal row4 : std_logic_vector (31 downto 0);
  signal row3 : std_logic_vector (31 downto 0);
  signal row2 : std_logic_vector (31 downto 0);
begin
  Row5_1:
    for n in 15 downto 0 generate
      MUXx : mux port map (y(4), x(n), '0', row5(n));
  end generate Row5_1;
  
  Row5_2:
    for n in 31 downto 16 generate
      MUXx : mux port map (y(4), x(n), x(n-16), row5(n));
  end generate Row5_2;
  
  Row4_1:
    for n in 7 downto 0 generate
      MUXx : mux port map (y(3), row5(n), '0', row4(n));
  end generate Row4_1;
  
  Row4_2:
    for n in 31 downto 8 generate
      MUXx : mux port map (y(3), row5(n), row5(n-8), row4(n));
  end generate Row4_2;
  
  Row3_1:
    for n in 3 downto 0 generate
      MUXx : mux port map (y(2), row4(n), '0', row3(n));
  end generate Row3_1;
  
  Row3_2:
    for n in 31 downto 4 generate
      MUXx : mux port map (y(2), row4(n), row4(n-4), row3(n));
  end generate Row3_2;
  
  Row2_1:
    for n in 1 downto 0 generate
      MUXx : mux port map (y(1), row3(n), '0', row2(n));
  end generate Row2_1;
  
  Row2_2:
    for n in 31 downto 2 generate
      MUXx : mux port map (y(1), row3(n), row3(n-2), row2(n));
  end generate Row2_2;
  
  Row1_1:
    for n in 31 downto 1 generate
      MUXx : mux port map (y(0), row2(n), row2(n-1), z(n));
  end generate Row1_1;
  

  muxLAST : mux port map (y(0), row2(0), '0', z(0));
end struct;