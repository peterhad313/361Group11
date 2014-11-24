
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
  signal row1 : std_logic_vector (31 downto 0);
begin
  Row5_1:
    for n in 15 downto 0 generate
      MUXx : mux port map (y(4), x(n), x(n+16), row5(n));
  end generate Row5_1;
  
  Row5_2:
    for n in 31 downto 16 generate
      MUXx : mux port map (y(4), x(n), '0', row5(n));
  end generate Row5_2;
  
  Row4_1:
    for n in 23 downto 0 generate
      MUXx : mux port map (y(3), row5(n), row5(n+8), row4(n));
  end generate Row4_1;
  
  Row4_2:
    for n in 31 downto 24 generate
      MUXx : mux port map (y(3), row5(n), '0', row4(n));
  end generate Row4_2;
  
  Row3_1:
    for n in 27 downto 0 generate
      MUXx : mux port map (y(2), row4(n), row4(n+4), row3(n));
  end generate Row3_1;
  
  Row3_2:
    for n in 31 downto 28 generate
      MUXx : mux port map (y(2), row4(n), '0', row3(n));
  end generate Row3_2;
  
  Row2_1:
    for n in 29 downto 0 generate
      MUXx : mux port map (y(1), row3(n), row3(n+2), row2(n));
  end generate Row2_1;
  
  Row2_2:
    for n in 31 downto 30 generate
      MUXx : mux port map (y(1), row3(n), '0', row2(n));
  end generate Row2_2;
  
  Row1_1:
    for n in 30 downto 0 generate
      MUXx : mux port map (y(0), row2(n), row2(n+1), row1(n));
  end generate Row1_1;
  

  muxLAST : mux port map (y(0), row2(31), '0', row1(31));
z(0)<=row1(31);
z(1)<=row1(30);
z(2)<=row1(29);
z(3)<=row1(28);
z(4)<=row1(27);
z(5)<=row1(26);
z(6)<=row1(25);
z(7)<=row1(24);
z(8)<=row1(23);
z(9)<=row1(22);
z(10)<=row1(21);
z(11)<=row1(20);
z(12)<=row1(19);
z(13)<=row1(18);
z(14)<=row1(17);
z(15)<=row1(16);
z(16)<=row1(15);
z(17)<=row1(14);
z(18)<=row1(13);
z(19)<=row1(12);
z(20)<=row1(11);
z(21)<=row1(10);
z(22)<=row1(9);
z(23)<=row1(8);
z(24)<=row1(7);
z(25)<=row1(6);
z(26)<=row1(5);
z(27)<=row1(4);
z(28)<=row1(3);
z(29)<=row1(2);
z(30)<=row1(1);
z(31)<=row1(0);

end struct;