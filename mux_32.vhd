library ieee;
use ieee.std_logic_1164.all;


entity mux_32 is
  port (
	sel   : in  std_logic;
	src0  : in  std_logic_vector(31 downto 0);
	src1  : in  std_logic_vector(31 downto 0);
	z	    : out std_logic_vector(31 downto 0)
  );
end mux_32;

architecture structural of mux_32 is
  
    component mux_n is
  generic (
	n	: integer
  );
  port (
	sel	  : in	std_logic;
	src0  :	in	std_logic_vector(n-1 downto 0);
	src1  :	in	std_logic_vector(n-1 downto 0);
	z	  : out std_logic_vector(n-1 downto 0)
  );
end component;
  
  
begin
  mux_map: mux_n
	generic map (n => 32)
	port map (
	  sel => sel,
	  src0 => src0,
	  src1 => src1,
	  z => z);
end structural;

