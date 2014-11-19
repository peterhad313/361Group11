library ieee;
use ieee.std_logic_1164.all;

entity mux_3bit is
  port (
	sel	  : in	std_logic_vector(3 downto 0);
	src0  : in	std_logic_vector(31 downto 0);
	src1  :	in	std_logic_vector(31 downto 0);
	src2  :	in	std_logic_vector(31 downto 0);
	src3  :	in	std_logic_vector(31 downto 0);
	src4  :	in	std_logic_vector(31 downto 0);
	src5  :	in	std_logic_vector(31 downto 0);
	src6  :	in	std_logic_vector(31 downto 0);
	src7  : in std_logic_vector(31 downto 0);
	z	    : out std_logic_vector(31 downto 0)
  );
end mux_3bit;

architecture structural of mux_3bit is
  component mux_32 is
  port (
	sel   : in  std_logic;
	src0  : in  std_logic_vector(31 downto 0);
	src1  : in  std_logic_vector(31 downto 0);
	z	    : out std_logic_vector(31 downto 0)
  );
end component;
component not_gate is
  port (
    x   : in  std_logic;
    z   : out std_logic
  );
end component;

	signal intermediate1 : std_logic_vector(31 downto 0);
	signal intermediate2 : std_logic_vector(31 downto 0);
  signal intermediate3 : std_logic_vector(31 downto 0);
  signal intermediate4 : std_logic_vector(31 downto 0);
  signal intermediate5 : std_logic_vector(31 downto 0);
  signal intermediate6 : std_logic_vector(31 downto 0);
  signal notSel0 : std_logic;
  signal notSel1 : std_logic;
begin	
	n1: not_gate port map ( sel(0), notSel0);
	n2: not_gate port map ( sel(1), notSel1);
	m1: mux_32 port map (sel(0),src3,src2,intermediate1);
	m2: mux_32 port map (notSel0,src0,src1,intermediate2);
	m3: mux_32 port map (notSel0,src5,src4,intermediate3);
	m4: mux_32 port map (notSel0,src7,src6,intermediate4);  
	m5: mux_32 port map (sel(1),intermediate1,intermediate2,intermediate5);
	m6: mux_32 port map (notSel1,intermediate3,intermediate4,intermediate6);
	m7: mux_32 port map (sel(2), intermediate5, intermediate6,z);
end structural;