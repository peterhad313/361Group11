library ieee;
use ieee.std_logic_1164.all;

entity mux_4input is
  port (
	sel	  : in	std_logic_vector(1 downto 0);
	src0  : in	std_logic_vector(31 downto 0);
	src1  :	in	std_logic_vector(31 downto 0);
	src2  :	in	std_logic_vector(31 downto 0);
	src3  :	in	std_logic_vector(31 downto 0);
	z	    : out std_logic_vector(31 downto 0)
  );
end mux_4input;

architecture structural of mux_4input is
  component mux_32 is
  port (
	sel   : in  std_logic;
	src0  : in  std_logic_vector(31 downto 0);
	src1  : in  std_logic_vector(31 downto 0);
	z	    : out std_logic_vector(31 downto 0)
  );
end component;

	signal intermediate1 : std_logic_vector(31 downto 0);
	signal intermediate2 : std_logic_vector(31 downto 0);

begin	
	m1: mux_32 port map (sel(0),src0,src1,intermediate1);
	m2: mux_32 port map (sel(0),src2,src3,intermediate2);
	m3: mux_32 port map (sel(1),intermediate1,intermediate2,z);
end structural;

